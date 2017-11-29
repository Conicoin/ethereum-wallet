// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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
  
  var description: CustomError.ErrorInfo? {
    switch self {
    case .noJsonKey:
      return criticalError
    case .noPassphrase:
      return criticalError
    }
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
