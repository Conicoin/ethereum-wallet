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

class TransactionFactory: TransactionFactoryProtocol {
  
  let keystore: KeystoreService
  let client: GethEthereumClient
  let context: GethContext
  
  init(keystore: KeystoreService, core: Ethereum) {
    self.keystore = keystore
    self.client = core.client
    self.context = core.context
  }
  
  func buildTransaction(with info: TransactionInfo, type: TransferType) throws -> GethTransaction {
    switch type {
    case .default:
      return try buildTransaction(with: info)
    case .token:
      return try buildTokenTransaction(with: info)
    }
  }

}


// MARK: Privates

extension TransactionFactory {
  
  private func buildTransaction(with info: TransactionInfo) throws -> GethTransaction {
    var error: NSError?
    let receiverAddress = info.contractAddress ?? info.address
    let gethAddress = GethNewAddressFromHex(receiverAddress, &error)
    var noncePointer: Int64 = 0
    let account = try keystore.getAccount(at: 0)
    try client.getNonceAt(context, account: account.getAddress(), number: -1, nonce: &noncePointer)
    
    let intAmount = GethNewBigInt(0)
    intAmount?.setString(info.amount.toHex(), base: 16)
    
    let gethGasLimit = GethNewBigInt(0)
    gethGasLimit?.setString(info.gasLimit.toHex(), base: 16)
    let gasPrice = try client.suggestGasPrice(context)
    
    return GethNewTransaction(noncePointer, gethAddress, intAmount, gethGasLimit, gasPrice, nil)
  }
  
  private func buildTokenTransaction(with info: TransactionInfo) throws -> GethTransaction {
    let transactionTemplate = try buildTransaction(with: info)
    let transferSignature = Data(bytes: [0xa9, 0x05, 0x9c, 0xbb])
    let address = info.address.lowercased().replacingOccurrences(of: "0x", with: "")
    let intAmount = (info.amount as NSDecimalNumber).int64Value
    let amount = String(format: "%064x", intAmount)
    let hexData = transferSignature.toHexString() + "000000000000000000000000" + address + amount
    guard let data = hexData.toHexData() else {
      throw TransactionFactoryError.badSignature
    }
    let nonce = transactionTemplate.getNonce()
    let to = transactionTemplate.getTo()
    let fakeAmount = GethBigInt(0)
    let gasLimit = GethBigInt(transactionTemplate.getGas())
    let gasPrice = transactionTemplate.getGasPrice()
    return GethNewTransaction(nonce, to, fakeAmount, gasLimit, gasPrice, data)
  }
  
}

enum TransactionFactoryError: Error {
  case badSignature
}
