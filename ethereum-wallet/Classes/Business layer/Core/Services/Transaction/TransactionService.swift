// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
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
