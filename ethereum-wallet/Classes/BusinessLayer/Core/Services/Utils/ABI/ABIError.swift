//
//  ABIError.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

enum ABIError: LocalizedError {
  case integerOverflow
  case invalidUTF8String
  case invalidNumberOfArguments
  case invalidArgumentType
  case functionSignatureMismatch
  
  public var errorDescription: String? {
    switch self {
    case .integerOverflow:
      return "Integer overflow"
    case .invalidUTF8String:
      return "Can't encode string as UTF8"
    case .invalidNumberOfArguments:
      return "Invalid number of arguments"
    case .invalidArgumentType:
      return "Invalid argument type"
    case .functionSignatureMismatch:
      return "Function signature mismatch"
    }
  }
}
