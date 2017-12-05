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
  func getSuggestedGasLimit() throws -> Int64
  func getSuggestedGasPrice() throws -> Int64
  func sendTransaction(amountHex: String, to: String, gasLimitHex: String, passphrase: String) throws
  func createAccount(passphrase: String) throws -> GethAccount
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data
}


class Ethereum: EthereumCoreProtocol {
  
  static let core: EthereumCoreProtocol = Ethereum()
  
  let syncQueue = DispatchQueue(label: "com.ethereum-wallet.sync")
  
  private var context: GethContext!
  private var client: GethEthereumClient!
  private var chain: Chain!
  
  private var syncTimer: DispatchSourceTimer?
  private var syncHandler: SyncHandler!
  private var balanceHandler:  BalanceHandler!
  private var node: NodeProtocol!
  
  private var isSyncing = false
  private var isSyncingFinished = false
  
  lazy private var keystore: KeystoreProtocol! = {
    return Keystore()
  }()
  
  lazy private var transactionPublisher: TransactionPublisherProtocol! = {
    return TransactionPublisher(context: context, client: client)
  }()
  
  
  // MARK: - Synchronization public
  
  func startSync(chain: Chain, balanceHandler: BalanceHandler, syncHandler: SyncHandler) throws {
    GethSetVerbosity(9)
    
    self.balanceHandler = balanceHandler
    self.syncHandler = syncHandler
    
    self.chain = chain
    self.context = GethNewContext()!
    self.client = try self.startNode(chain: chain)
    
    try self.startProgressTicks()
    try self.subscribeNewHead()
  }
  
  deinit {
    try? node.stop()
  }
  
}


// MARK: - Transactions

extension Ethereum {
  
  func sendTransaction(amountHex: String, to: String, gasLimitHex: String, passphrase: String) throws {
    let account = try keystore.getAccount(at: 0)
    let transaction = try transactionPublisher.createTransaction(amountHex: amountHex, to: to, gasLimitHex: gasLimitHex, account: account)
    let signedTransaction = try keystore.signTransaction(transaction, account: account, passphrase: passphrase, chainId: chain.chainId)
    try transactionPublisher.sendTransaction(signedTransaction)
  }
  
}


// MARK: - Keystore

extension Ethereum {
  
  func createAccount(passphrase: String) throws -> GethAccount {
    return try keystore.createAccount(passphrase: passphrase)
  }
  
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount {
    return try keystore.restoreAccount(with: jsonKey, passphrase: passphrase)
  }
  
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data {
    return try jsonKey(for: account, passphrase: passphrase)
  }
  
}


// MARK: - Synchronization privates

extension Ethereum {
  
  // MARK: - Creating node
  
  private func startNode(chain: Chain) throws -> GethEthereumClient {
    self.node = try Node(chain: chain)
    try node.start()
    return try node.ethereumClient()
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
        
        let address = try self.keystore.getAccount(at: 0).getAddress()!
        let balance = try self.node.ethereumClient().getBalanceAt(self.context, account: address, number: header.getNumber()) // TODO: change to try! gethClient.getBalanceAt(GethNewContext(), account: address!, number: -1)
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
    try client.subscribeNewHead(context, handler: newBlockHandler, buffer: 16)
  }
  
  
  // MARK: - Synchronization status
  
  private func startProgressTicks() throws {
    syncTimer = Timer.createDispatchTimer(interval: .seconds(1), leeway: .seconds(0), queue: syncQueue) {
        self.timerTick()
    }
  }
  
  private func timerTick() {
    if let syncProgress = try? client.syncProgress(context) {
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
      let block = try! client.getBlockByNumber(context, number: blockNumber)
      let blockTransactions = block.getTransactions()!
      
      for index in 0...blockTransactions.size()  {
        guard let transaction = try? blockTransactions.get(index) else {
          continue
        }
        
        let from = try? client.getTransactionSender(context, tx: transaction, blockhash: block.getHash(), index: index)
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
    let gasLimit = try client.estimateGas(context, msg: msg)
    return gasLimit.getInt64()
  }
  
  /// SuggestGasPrice retrieves the currently suggested gas price to allow a timely
  /// execution of a transaction.
  ///
  /// - Returns: Int64 GasPrice
  func getSuggestedGasPrice() throws -> Int64 {
    let gasPrice = try client.suggestGasPrice(context)
    return gasPrice.getInt64()
  }
  
}
