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


import Geth

class TransactionService: TransactionServiceProtocol {
  
  private let context: GethContext
  private let client: GethEthereumClient
  private let keystore: KeystoreService
  private let chain: Chain
  
  init(core: Ethereum, keystore: KeystoreService) {
    // TODO: Check objects
    self.context = core.context
    self.client = core.client
    self.chain = core.chain
    self.keystore = keystore
  }
  
  func sendAndReturnTransaction(amountHex: String, to: String, gasLimitHex: String, passphrase: String) throws -> GethTransaction {
    let account = try keystore.getAccount(at: 0)
    let transaction = try createTransaction(amountHex: amountHex, to: to, gasLimitHex: gasLimitHex, account: account)
    let signedTransaction = try keystore.signTransaction(transaction, account: account, passphrase: passphrase, chainId: chain.chainId)
    try sendTransaction(signedTransaction)
    return signedTransaction
  }
  
  private func createTransaction(amountHex: String, to: String, gasLimitHex: String, account: GethAccount) throws -> GethTransaction {
    var error: NSError?
    let gethAddress = GethNewAddressFromHex(to, &error)
    var noncePointer: Int64 = 0
    try client.getNonceAt(context, account: account.getAddress(), number: -1, nonce: &noncePointer)
    
    let intAmount = GethNewBigInt(0)
    intAmount?.setString(amountHex, base: 16)
    
    let gasLimit = GethNewBigInt(0)
    gasLimit?.setString(gasLimitHex, base: 16)
    let gasPrice = try client.suggestGasPrice(context)
    
    return GethNewTransaction(noncePointer, gethAddress, intAmount, gasLimit, gasPrice, nil)
  }
  
  private func sendTransaction(_ signedTransaction: GethTransaction) throws {
    try client.sendTransaction(context, tx: signedTransaction)
  }

}
