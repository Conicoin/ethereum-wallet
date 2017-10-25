//  MIT License
//
//  Copyright (c) 2017 Artur Guseinov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import Geth


// MARK: - EthereumCoreProtocol

protocol EthereumCoreProtocol {
  var syncQueue: DispatchQueue { get }
  func startSync(balanceHandler: BalanceHandler, syncHandler: SyncHandler) throws
  func createAccount(passphrase: String) throws -> GethAccount
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount
  func getTransactions(address: String, startBlockNumber: Int64, endBlockNumber: Int64) -> [GethTransaction] 
}


class Ethereum: EthereumCoreProtocol {
  
  static var core: EthereumCoreProtocol = Ethereum()
  
  let syncQueue = DispatchQueue(label: "com.ethereum-wallet.sync")
  
  fileprivate lazy var keystore: GethKeyStore! = {
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return GethNewKeyStore(documentDirectory + "/keystore", GethLightScryptN, GethLightScryptP)
  }()
  
  fileprivate var syncTimer: DispatchSourceTimer?
  fileprivate var syncHandler: SyncHandler!
  fileprivate var balanceHandler:  BalanceHandler!
  fileprivate var ethereumContext: GethContext = GethNewContext()
  fileprivate var ethereumNode:    GethNode!
  fileprivate var ethereumClient:  GethEthereumClient!
  
  fileprivate var isSyncMode = false
  
  
  // MARK: - Synchronization public
  
  func startSync(balanceHandler: BalanceHandler, syncHandler: SyncHandler) throws {
    //    GethSetVerbosity(9)
    self.balanceHandler = balanceHandler
    self.syncHandler = syncHandler
    try self.startNode()
    try self.startProgressTicks()
    try self.subscribeNewHead()
  }
  
  
  // MARK: - Acount managment public
  
  func createAccount(passphrase: String) throws -> GethAccount {
    guard keystore.getAccounts().size() == 0 else {
      throw EthereumError.accountExist
    }
    
    return try keystore.newAccount(passphrase)
  }
  
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data {
    return try keystore.exportKey(account, passphrase: passphrase, newPassphrase: passphrase)
  }
  
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount  {
    return try keystore.importKey(jsonKey, passphrase: passphrase, newPassphrase: passphrase)
  }
  
  func getTransactions(address: String, startBlockNumber: Int64, endBlockNumber: Int64) -> [GethTransaction] {
    
    var transactions = [GethTransaction]()
    for blockNumber in startBlockNumber...endBlockNumber {
      let block = try! ethereumClient.getBlockByNumber(ethereumContext, number: blockNumber)
      let blockTransactions = block.getTransactions()!
      
      for index in 0...blockTransactions.size()  {
        guard let transaction = try? blockTransactions.get(index) else {
          continue
        }
        
        let from = try? ethereumClient.getTransactionSender(ethereumContext, tx: transaction, blockhash: block.getHash(), index: index)
        let to = transaction.getTo()
        
        if to?.getHex() == address || from?.getHex() == address {
          transactions.append(transaction)
        }
      }
    }
    return transactions
  }
  
}


// MARK: - Synchronization privates

extension Ethereum {
  
  fileprivate func startNode() throws {
    
    var error: NSError?
    let bootNodes = GethNewEnodesEmpty()
    bootNodes?.append(GethNewEnode(Constants.Ethereum.enodeRawUrl, &error))
    
    let genesisPath = Bundle.main.path(forResource: "rinkeby", ofType: "json")
    let genesis = try! String(contentsOfFile: genesisPath!, encoding: String.Encoding.utf8)
    
    let config = GethNewNodeConfig()
    config?.setBootstrapNodes(bootNodes)
    config?.setEthereumGenesis(genesis)
    config?.setEthereumNetworkID(4)
    config?.setEthereumNetStats("flypaper:Respect my authoritah!@stats.rinkeby.io")
    
    let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    ethereumNode = GethNewNode(datadir + "/.rinkeby", config, &error)
    
    try ethereumNode.start()
    ethereumClient = try ethereumNode.getEthereumClient()
    
    if let error = error {
      throw EthereumError.nodeStartFailed(error: error)
    }
  }
  
  fileprivate func subscribeNewHead() throws {
    
    let newBlockHandler = NewHeadHandler(errorHandler: nil) { header in
      do {
        let address = try self.keystore.getAccounts().get(0).getAddress()!
        let balance = try self.ethereumClient.getBalanceAt(self.ethereumContext, account: address, number: header.getNumber())
        self.balanceHandler.didUpdateBalance(balance.getInt64())
        
        
        if !self.isSyncMode {
          let transactions = self.getTransactions(address: address.getHex(), startBlockNumber: header.getNumber(), endBlockNumber: header.getNumber())
          if !transactions.isEmpty {
            self.balanceHandler.didReceiveTransactions(transactions)
          }
        }
      } catch {}
    }
    try ethereumClient.subscribeNewHead(ethereumContext, handler: newBlockHandler, buffer: 16)
  }
    
  
  fileprivate func startProgressTicks() throws {
    syncTimer = Timer.createDispatchTimer(interval: .seconds(1), leeway: .seconds(0), queue: syncQueue) {
      self.timerTick()
    }
  }
  
  fileprivate func timerTick() {
    if let syncProgress = try? self.ethereumClient.syncProgress(self.ethereumContext) {
      
      let currentBlock = syncProgress.getCurrentBlock()
      let highestBlock = syncProgress.getHighestBlock()

      self.syncHandler?.didChangeProgress(currentBlock, highestBlock)
      self.isSyncMode = true
      
    } else if self.isSyncMode {
      self.syncHandler?.didFinished()
      self.isSyncMode = false
      syncTimer?.cancel()
    }
  }
  
}
