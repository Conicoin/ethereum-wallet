//
//  Errors.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol CustomError: Error {
  typealias ErrorInfo = (title: String?, message: String?, showing: Bool)
  var description: ErrorInfo? { get }
}


// MARK - Keychain errors

enum KeychainError: CustomError {
  
  case noJsonKey
  
  var description: CustomError.ErrorInfo? {
    return nil
  }
  
}


// MARK - Ethereum core errors

enum EthereumError: CustomError {
  
  case nodeStartFailed(error: NSError)
  case accountExist
  
  var description: ErrorInfo? {
    switch self {
    case .nodeStartFailed(let error):
      return ("Starting node error", error.localizedDescription, true)
    case .accountExist:
      return (nil, "Account already exist", true)
    }
  }
  
}
