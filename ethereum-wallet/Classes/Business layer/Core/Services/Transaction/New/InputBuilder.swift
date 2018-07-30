//
//  InputBuilder.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 30/07/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//
import Foundation

protocol EthTxInputBuilderProtocol {
  func createInput(amount: Decimal, receiverAddress: String) throws -> Data
}

class EthDefaultTxInputBuilder: EthTxInputBuilderProtocol {
  
  func createInput(amount: Decimal, receiverAddress: String) throws -> Data {
    return Data(hex: "0x")
  }
  
}

class EthTokenTxInputBuilder: EthTxInputBuilderProtocol {
  
  let decimals: Int
  
  init(decimals: Int) {
    self.decimals = decimals
  }
  
  /// The first 32 bit a9059cbb is the first 32 bit of the hash of the function.
  /// In this case the function is transfer(address _to, uint256 _value).
  /// This is followed by 256 bit for each argument, so in this case the address and amount to send
  func createInput(amount: Decimal, receiverAddress: String) throws -> Data {
    let transferSignature = Data(bytes: [0xa9, 0x05, 0x9c, 0xbb])
    let address = receiverAddress.lowercased().replacingOccurrences(of: "0x", with: "")
    let weiAmount = amount * pow(10, decimals)
    let hexAmount = weiAmount.toHex().withLeadingZero(64)
    let hexData = transferSignature.hex() + "000000000000000000000000" + address + hexAmount
    guard let data = hexData.toHexData() else {
      throw Errors.badSignature
    }
    return data
  }
  
  enum Errors: Error {
    case badSignature
  }
  
}
