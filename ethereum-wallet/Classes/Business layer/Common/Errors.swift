// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol CustomError: Error {
  typealias ErrorInfo = (title: String?, message: String?, showing: Bool)
  var description: ErrorInfo? { get }
}

extension CustomError {
  var criticalError: ErrorInfo {
    return (title: "Critical error", message: "Something went wront. Please contact with developers", showing: true)
  }
}


// MARK: - Keychain errors

enum KeychainError: CustomError {
  
  case noJsonKey
  case noPassphrase
  case keyIsInvalid
  
  var description: CustomError.ErrorInfo? {
    switch self {
    case .noJsonKey:
      return criticalError
    case .noPassphrase:
      return criticalError
    case .keyIsInvalid:
      return (title: "Invalid key", message: "The provided key is not valid", showing: true)
    }
  }
  
}

enum KeystoreError: CustomError {
  case noJsonKey
  
  var description: CustomError.ErrorInfo? {
    return criticalError
  }
}

enum NetworkError: CustomError {
  case parseError
  
  var description: CustomError.ErrorInfo? {
    return nil
  }
}


// MARK: - Ethereum core errors

enum EthereumError: CustomError {
  
  case nodeStartFailed(error: NSError)
  case accountExist
  case couldntGetNonce
  case alreadySubscribed
  
  var description: ErrorInfo? {
    switch self {
    case .nodeStartFailed(let error):
      return ("Starting node error", error.localizedDescription, true)
    case .accountExist:
      return (nil, "Account already exist", true)
    default:
      return nil
    }
  }
  
}

// MARK: - Send errors

enum SendError: CustomError {
  
  case coinNotFound
  
  var description: ErrorInfo? {
    return nil
  }
  
}

// MARK: - SendCheckout errors

enum SendCheckoutError: CustomError {
  
  case noRate
  
  var description: ErrorInfo? {
    return ("Currency rates haven't been downloaded for some reasons", nil, false)
  }
  
}

// MARK: - TouchId errors

enum TouchIdError: CustomError {
  
  case error(error: NSError?)
  
  var description: ErrorInfo? {
    switch self {
    case .error(let error):
      return (Localized.touchIdErrorTitle(), error?.touchIdMessage(), true)
    }
  }
  
}

// MARK: - Import errors

enum ImportError: CustomError {
  case invalidLength
  case invalidFormat
  case invalidMnemonic
  
  var description: ErrorInfo? {
    switch self {
    case .invalidLength:
      return ("Import error", "Invalid key length", true)
    case .invalidFormat:
      return ("Import error", "Invalid format", true)
    case .invalidMnemonic:
      return ("Import error", "Invalid mnemonic", true)
    }
  }
}
