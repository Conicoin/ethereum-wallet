// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
