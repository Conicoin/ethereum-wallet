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
    
    let kSecClassGenericPasswordValue = String(format: kSecClassGenericPassword as String)
    let kSecClassValue = String(format: kSecClass as String)
    let kSecAttrServiceValue = String(format: kSecAttrService as String)
    let kSecValueDataValue = String(format: kSecValueData as String)
    let kSecMatchLimitValue = String(format: kSecMatchLimit as String)
    let kSecReturnDataValue = String(format: kSecReturnData as String)
    let kSecMatchLimitOneValue = String(format: kSecMatchLimitOne as String)
    let kSecAttrAccountValue = String(format: kSecAttrAccount as String)
    let kSecAttrAccessibleValue = String(format: kSecAttrAccessible as String)
    
    func set(_ data: Data, for key: String) throws {
       
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
        print("\(key) saved in keychain")
    }
    
    func get(for key: String) throws -> Data {
        
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
        
        print("\(key) returned from keychain")
        
        return data
    }
}
