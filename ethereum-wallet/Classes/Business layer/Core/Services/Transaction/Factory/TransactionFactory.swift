//
//  TransactionFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Geth
import CryptoSwift

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
