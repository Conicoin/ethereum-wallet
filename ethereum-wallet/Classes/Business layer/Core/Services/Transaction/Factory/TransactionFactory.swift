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
    let weiAmount = info.amount * 1e18
    intAmount?.setString(weiAmount.toHex(), base: 16)
    
    let gethGasLimit = info.settings.gasLimit.int64
    let gethGasPrice = GethNewBigInt(0)
    gethGasPrice?.setString(info.settings.gasPrice.toHex(), base: 16)
    
    let data = info.settings.txData
    return GethNewTransaction(noncePointer, gethAddress, intAmount, gethGasLimit, gethGasPrice, data)
  }
  
  private func buildTokenTransaction(with info: TransactionInfo) throws -> GethTransaction {
    let transactionTemplate = try buildTransaction(with: info)
    let transferSignature = Data(bytes: [0xa9, 0x05, 0x9c, 0xbb])
    let address = info.address.lowercased().replacingOccurrences(of: "0x", with: "")
    let weiAmount = info.amount * 1e18
    let hexAmount = weiAmount.toHex().withLeadingZero(64)
    let hexData = transferSignature.hex() + "000000000000000000000000" + address + hexAmount
    guard let data = hexData.toHexData() else {
      throw TransactionFactoryError.badSignature
    }
    let nonce = transactionTemplate.getNonce()
    let to = transactionTemplate.getTo()
    let gasLimit = transactionTemplate.getGas()
    let gasPrice = transactionTemplate.getGasPrice()
    return GethNewTransaction(nonce, to, GethBigInt(0), gasLimit, gasPrice, data)
  }
  
}

enum TransactionFactoryError: Error {
  case badSignature
}
