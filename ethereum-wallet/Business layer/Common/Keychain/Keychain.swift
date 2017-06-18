//
//  Keychain.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Security

struct Keychain {
    
    private static let kSecClassGenericPasswordValue = String(format: kSecClassGenericPassword as String)
    private static let kSecClassValue = String(format: kSecClass as String)
    private static let kSecAttrServiceValue = String(format: kSecAttrService as String)
    private static let kSecValueDataValue = String(format: kSecValueData as String)
    private static let kSecMatchLimitValue = String(format: kSecMatchLimit as String)
    private static let kSecReturnDataValue = String(format: kSecReturnData as String)
    private static let kSecMatchLimitOneValue = String(format: kSecMatchLimitOne as String)
    private static let kSecAttrAccountValue = String(format: kSecAttrAccount as String)
    private static let kSecAttrAccessibleValue = String(format: kSecAttrAccessible as String)
    
    static func set(_ data: Data, for key: String) throws {
       
        var query = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: Constants.Keychain.serviceName,
            kSecAttrAccountValue: key,
            kSecReturnDataValue: kCFBooleanTrue
        ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        query.removeValue(forKey: kSecReturnDataValue)
        query.updateValue(data, forKey: kSecValueDataValue)
        query.updateValue(kSecAttrAccessibleWhenUnlockedThisDeviceOnly, forKey: kSecAttrAccessibleValue)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.notRetrieved(status: status)
        }
    }
    
    static func get(for key: String) throws -> Data {
        
        let query = [
            kSecClassValue: kSecClassGenericPasswordValue,
            kSecAttrServiceValue: Constants.Keychain.serviceName,
            kSecReturnDataValue: kCFBooleanTrue,
            kSecAttrAccountValue: key,
        ] as [String: Any]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            throw KeychainError.notRetrieved(status: status)
        }
        
        return data
    }
}
