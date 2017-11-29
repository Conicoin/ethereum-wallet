// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit
import Geth


// MARK: - EthereumCoreProtocol

protocol EthereumCoreProtocol {
  var syncQueue: DispatchQueue { get }
  func startSync(chain: Chain, balanceHandler: BalanceHandler, syncHandler: SyncHandler) throws
  func createAccount(passphrase: String) throws -> GethAccount
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount
  func sendTransaction(amountHex: String, to: String, gasLimitHex: String, passphrase: String) throws
  func getSuggestedGasLimit() throws -> Int64
  func getSuggestedGasPrice() throws -> Int64
}


class Ethereum: EthereumCoreProtocol {
  
  static var core: EthereumCoreProtocol = Ethereum()
  
  let syncQueue = DispatchQueue(label: "com.ethereum-wallet.sync")
  
  private lazy var keystore: GethKeyStore! = {
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return GethNewKeyStore(documentDirectory + "/keystore", GethLightScryptN, GethLightScryptP)
  }()
  
  private var syncTimer: DispatchSourceTimer?
  private var syncHandler: SyncHandler!
  private var balanceHandler:  BalanceHandler!
  private var ethereumContext: GethContext!
  private var node: NodeProtocol!
  
  private var _ethereumClient:  GethEthereumClient!
  
  private var isSyncing = false
  private var isSyncingFinished = false
  
  
  // MARK: - Synchronization public
  
  func startSync(chain: Chain, balanceHandler: BalanceHandler, syncHandler: SyncHandler) throws {
            GethSetVerbosity(9)
    self.balanceHandler = balanceHandler
    self.syncHandler = syncHandler
    self.ethereumContext = GethNewContext()
    try self.startNode(chain: chain)
    try self.startProgressTicks()
    try self.subscribeNewHead()
  }
  
  deinit {
    try? node.stop()
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
  
  
  /// Send transaction
  ///
  /// - Parameters:
  ///   - amount: Amount ot send base 16 string
  ///   - to: Recepient address
  ///   - gasLimit: Gas limit
  ///   - passphrase: Password to unlick wallet
  func sendTransaction(amountHex: String, to: String, gasLimitHex: String, passphrase: String) throws {
    var error: NSError?
    let gethAddress = GethNewAddressFromHex(to, &error)
    
    let account = try keystore.getAccounts().get(0)
    
    var noncePointer: Int64 = 0
    try node.ethereumClient().getNonceAt(ethereumContext, account: account.getAddress(), number: -1, nonce: &noncePointer)
    
    let intAmount = GethNewBigInt(0)
    intAmount?.setString(amountHex, base: 16)
    
    let gasLimit = GethNewBigInt(0)
    gasLimit?.setString(gasLimitHex, base: 16)
    let gasPrice = try node.ethereumClient().suggestGasPrice(ethereumContext)
    
    let transaction = GethNewTransaction(noncePointer, gethAddress, intAmount, gasLimit, gasPrice, nil)
    let chainId = GethBigInt(node.chain.chainId)
    let signedTransaction = try keystore.signTxPassphrase(account, passphrase: passphrase, tx: transaction, chainID: chainId)
    
    try node.ethereumClient().sendTransaction(ethereumContext, tx: signedTransaction)
  }
  
}


// MARK: - Synchronization privates

extension Ethereum {
  
  // MARK: - Creating node
  
  private func startNode(chain: Chain) throws {
    self.node = try Node(chain: chain)
    try node.start()
  }
  
  // MARK: - Subscribing on new head
  
  private func subscribeNewHead() throws {
    
    let newBlockHandler = NewHeadHandler(errorHandler: nil) { header in
      do {
        
        guard !self.isSyncing else {
          return
        }
        
        if !self.isSyncingFinished {
          self.syncHandler?.didFinished()
          self.syncTimer?.cancel()
          self.syncTimer = nil
          self.isSyncingFinished = true
        }
        
        let address = try self.keystore.getAccounts().get(0).getAddress()!
        let balance = try self.node.ethereumClient().getBalanceAt(self.ethereumContext, account: address, number: header.getNumber()) // TODO: change to try! gethClient.getBalanceAt(GethNewContext(), account: address!, number: -1)
        let time = header.getTime()
        
        // TODO: change to string
        self.balanceHandler.didUpdateBalance(balance.getString(16), time)
        self.balanceHandler.didUpdateGasLimit(header.getGasLimit())
        
        let transactions = self.getTransactions(address: address.getHex(), startBlockNumber: header.getNumber(), endBlockNumber: header.getNumber())
        if !transactions.isEmpty {
          self.balanceHandler.didReceiveTransactions(transactions, time)
        }
      } catch {}
    }
    try node.ethereumClient().subscribeNewHead(ethereumContext, handler: newBlockHandler, buffer: 16)
  }
  
  
  // MARK: - Synchronization status
  
  private func startProgressTicks() throws {
    syncTimer = Timer.createDispatchTimer(interval: .seconds(1), leeway: .seconds(0), queue: syncQueue) {
        self.timerTick()
    }
  }
  
  private func timerTick() {
    if let syncProgress = try? node.ethereumClient().syncProgress(ethereumContext) {
      let currentBlock = syncProgress.getCurrentBlock()
      let highestBlock = syncProgress.getHighestBlock()
      syncHandler?.didChangeProgress(currentBlock, highestBlock)
      isSyncing = true
    } else if isSyncing {
      isSyncing = false
    }
  }
  
  /// Retrive account connected transactions for defined blocks.
  /// VERY Resource-intensive operation.
  ///
  /// - Parameters:
  ///   - address: Ethereum address
  ///   - startBlockNumber: Search start block
  ///   - endBlockNumber: Search end block number
  /// - Returns: Array of GethTransactions
  private func getTransactions(address: String, startBlockNumber: Int64, endBlockNumber: Int64) -> [GethTransaction] {
    
    var transactions = [GethTransaction]()
    for blockNumber in startBlockNumber...endBlockNumber {
      let block = try! node.ethereumClient().getBlockByNumber(ethereumContext, number: blockNumber)
      let blockTransactions = block.getTransactions()!
      
      for index in 0...blockTransactions.size()  {
        guard let transaction = try? blockTransactions.get(index) else {
          continue
        }
        
        let from = try? node.ethereumClient().getTransactionSender(ethereumContext, tx: transaction, blockhash: block.getHash(), index: index)
        let to = transaction.getTo()
        
        if to?.getHex() == address || from?.getHex() == address {
          transactions.append(transaction)
        }
      }
    }
    return transactions
  }
  
  /// EstimateGas tries to estimate the gas needed to execute a specific transaction based on
  /// the current pending state of the backend blockchain. There is no guarantee that this is
  /// the true gas limit requirement as other transactions may be added or removed by miners,
  /// but it should provide a basis for setting a reasonable default.
  ///
  /// - Returns: Int64 GasLimit
  func getSuggestedGasLimit() throws -> Int64 {
    let msg = GethNewCallMsg()
    let gasLimit = try node.ethereumClient().estimateGas(ethereumContext, msg: msg)
    return gasLimit.getInt64()
  }
  
  /// SuggestGasPrice retrieves the currently suggested gas price to allow a timely
  /// execution of a transaction.
  ///
  /// - Returns: Int64 GasPrice
  func getSuggestedGasPrice() throws -> Int64 {
    let gasPrice = try node.ethereumClient().suggestGasPrice(ethereumContext)
    return gasPrice.getInt64()
  }
  
}
