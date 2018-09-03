// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

class TransactionService: TransactionServiceProtocol {
  
  private let context: GethContext
  private let client: GethEthereumClient
  private let keystore: KeystoreService
  private let chain: Chain
  private let factory: TransactionFactoryProtocol
  private let transferType: TransferType
  
  init(core: Ethereum, keystore: KeystoreService, transferType: TransferType) {
    self.context = core.context
    self.client = core.client
    self.chain = core.chain
    self.keystore = keystore
    self.transferType = transferType
    
    let factory = TransactionFactory(keystore: keystore, core: core)
    self.factory = factory
  }

  func sendTransaction(with info: TransactionInfo, passphrase: String, result: @escaping (Result<GethTransaction>) -> Void) {
    Ethereum.syncQueue.async {
      do {
        let account = try self.keystore.getAccount(at: 0)
        let transaction = try self.factory.buildTransaction(with: info, type: self.transferType)
        let signedTransaction = try self.keystore.signTransaction(transaction, account: account, passphrase: passphrase, chainId: self.chain.chainId)
        try self.sendTransaction(signedTransaction)
        DispatchQueue.main.async {
          result(.success(signedTransaction))
        }
      } catch {
        DispatchQueue.main.async {
          result(.failure(error))
        }
      }
    }
  }

  private func sendTransaction(_ signedTransaction: GethTransaction) throws {
    try client.sendTransaction(context, tx: signedTransaction)
  }

}
