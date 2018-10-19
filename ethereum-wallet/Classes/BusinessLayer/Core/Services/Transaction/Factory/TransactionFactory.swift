// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
  
  func buildTransaction(with info: TransactionInfo, type: CoinType) throws -> GethTransaction {
    switch type {
    case .default:
      return try buildTransaction(with: info, receiverAddress: info.address)
    case .token(let token):
      return try buildTokenTransaction(with: info, receiverAddress: token.address, decimals: token.decimals)
    }
  }

}


// MARK: Privates

extension TransactionFactory {
  
  private func buildTransaction(with info: TransactionInfo, receiverAddress: String, decimals: Int = 18) throws -> GethTransaction {
    var error: NSError?
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
  
  private func buildTokenTransaction(with info: TransactionInfo, receiverAddress: String, decimals: Int) throws -> GethTransaction {
    let transactionTemplate = try buildTransaction(with: info, receiverAddress: receiverAddress, decimals: decimals)
    let transferSignature = Data(bytes: [0xa9, 0x05, 0x9c, 0xbb])
    let address = info.address.lowercased().replacingOccurrences(of: "0x", with: "")
    let weiAmount = info.amount * pow(10, decimals)
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
