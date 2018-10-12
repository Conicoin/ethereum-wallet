//
//  ContractCall.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol ContractCall {
  var method: String { get }
  var params: [ContractCallParam] { get }
}

extension ContractCall {
  
  func encode() -> String {
    var raw = "0x" + method.toData().sha3(.keccak256).hex().substring(toIndex: 8)
    for param in params {
      raw.append(param.encode())
    }
    return raw
  }
}

enum ContractCallParam {
  case string(String)
  case uint(UInt)
  
  func encode() -> String {
    switch self {
    case .string(let string):
      let hex = string.toData().hex()
      return hex.withLeadingZero(64)
    case .uint(let uint):
      let hex = String(uint, radix: 16, uppercase: false)
      return hex.withLeadingZero(64)
    }
  }
}
