//
//  GasCallMsgBuilder.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import Geth

protocol GasCallMsgBuilder {
  func build(from: String, to: String, amount: Decimal, settings: SendSettings) throws -> GethCallMsg
}

class DefaultCallMsgBuilder: GasCallMsgBuilder {
  
  func build(from: String, to: String, amount: Decimal, settings: SendSettings) throws -> GethCallMsg {
    let msg = GethNewCallMsg()!
    
    // Sender
    let fromAddress = GethAddress(fromHex: from)
    msg.setFrom(fromAddress)
    
    // Receiver
    let toAddress = GethAddress(fromHex: to)
    msg.setTo(toAddress)
    
    // Value
    let bigInt = GethNewBigInt(0)!
    let weiAmount = amount * 1e18
    bigInt.setString(weiAmount.string, base: 10)
    msg.setValue(bigInt)
    
    // GasPrice
    let bigGasPrice = GethNewBigInt(0)!
    bigGasPrice.setString(settings.gasPrice.string, base: 10)
    msg.setGasPrice(bigGasPrice)
    
    // Data
    if let data = settings.txData {
      msg.setData(data)
    }
    
    return msg
  }
  
}

class TokenCallMsgBuilder: GasCallMsgBuilder {
  
  let inputBuilder: EthTxInputBuilder
  let contractAddress: String
  
  init(inputBuilder: EthTxInputBuilder, contractAddress: String) {
    self.inputBuilder = inputBuilder
    self.contractAddress = contractAddress
  }
  
  func build(from: String, to: String, amount: Decimal, settings: SendSettings) throws -> GethCallMsg {
    let msg = GethNewCallMsg()!
    
    // Sender
    let fromAddress = GethAddress(fromHex: from)
    msg.setFrom(fromAddress)
    
    // Receiver
    let toAddress = GethAddress(fromHex: contractAddress)
    msg.setTo(toAddress)
    
    // GasPrice
    let bigGasPrice = GethNewBigInt(0)!
    bigGasPrice.setString(settings.gasPrice.string, base: 10)
    msg.setGasPrice(bigGasPrice)
    
    let data = try inputBuilder.createInput(amount: amount, receiverAddress: to)
    msg.setData(data)
    
    return msg
  }
}


