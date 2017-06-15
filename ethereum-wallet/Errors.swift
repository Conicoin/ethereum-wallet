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
    var description: ErrorInfo { get }
}


// MARK - Keychain errors

enum KeychainError: CustomError {
    
    case notSaved(status: Int32)
    case notRetrieved(status: Int32)
    
    var description: ErrorInfo {
        switch self {
            
        case .notSaved(let status):
            return ("Not saved", "Value not saved in keychain. Status code \(status)", true)
            
        case .notRetrieved(let status):
            return ("Not retrieved", "Nothing was retrieved from the keychain. Status code \(status)", true)
        }
    }
    
}


// MARK - Ethereum core errors

enum EthereumError: CustomError {
    
    case nodeStartFailed(error: NSError)
    
    var description: ErrorInfo {
        switch self {
        case .nodeStartFailed(let error):
            return ("Starting node error", error.localizedDescription, true)
        }
    }
    
}
