//  MIT License
//
//  Copyright (c) 2017 Artur Guseinov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import Security

class Keychain {
  
  let serviceName = "ethereum-wallet"
  
  private let kSecClassGenericPasswordValue = String(format: kSecClassGenericPassword as String)
  private let kSecClassValue = String(format: kSecClass as String)
  private let kSecAttrServiceValue = String(format: kSecAttrService as String)
  private let kSecValueDataValue = String(format: kSecValueData as String)
  private let kSecMatchLimitValue = String(format: kSecMatchLimit as String)
  private let kSecReturnDataValue = String(format: kSecReturnData as String)
  private let kSecMatchLimitOneValue = String(format: kSecMatchLimitOne as String)
  private let kSecAttrAccountValue = String(format: kSecAttrAccount as String)
  private let kSecAttrAccessibleValue = String(format: kSecAttrAccessible as String)
  
  fileprivate func set(_ data: Data?, for key: String) {
    
    guard let data = data else {
      delete(for: key)
      return
    }
    
    var query = generateQuery(for: key)
    
    SecItemDelete(query as CFDictionary)
    
    query.removeValue(forKey: kSecReturnDataValue)
    query.updateValue(data, forKey: kSecValueDataValue)
    query.updateValue(kSecAttrAccessibleWhenUnlockedThisDeviceOnly, forKey: kSecAttrAccessibleValue)
    
    let status = SecItemAdd(query as CFDictionary, nil)
    guard status == errSecSuccess else {
      return
    }
  }
  
  fileprivate func get(for key: String) -> Data? {
    
    let query = generateQuery(for: key)
    
    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    
    guard status == errSecSuccess, let data = dataTypeRef as? Data else {
      return nil
    }
    
    return data
  }
  
  fileprivate func delete(for key: String) {
    let query = generateQuery(for: key)
    SecItemDelete(query as CFDictionary)
  }
  
  fileprivate func generateQuery(for key: String) -> [String: Any] {
    return [
      kSecClassValue: kSecClassGenericPasswordValue,
      kSecAttrServiceValue: serviceName,
      kSecAttrAccountValue: key,
      kSecReturnDataValue: kCFBooleanTrue
    ]
  }
}

// MARK: - Keychain hepler bilders

extension Keychain {
  
  // MARK: - Data
  func getData(key: KeychainKeys) -> Data? {
    return get(for: key.rawValue)
  }
  
  func setData(_ value: Data?, for key: KeychainKeys) {
    set(value, for: key.rawValue)
  }
  
  // MARK: - String
  func getString(for key: KeychainKeys) -> String? {
    guard let data = get(for: key.rawValue),
      let value = String(data: data, encoding: .utf8) else {
        return nil
    }
    return value
  }
  
  func setString(_ value: String?, for key: KeychainKeys) {
    let data = value?.data(using: .utf8)
    set(data, for: key.rawValue)
  }
  
  // MARK: - Bool
  func getBool(for key: KeychainKeys) -> Bool {
    guard let _ = getString(for: key) else {
      return false
    }
    return true
  }
  
  func setBool(_ value: Bool, for key: KeychainKeys) {
    setString(value ? "true" : nil, for: key)
  }
  
  // MARK: - Date
  func getDate(key: KeychainKeys) -> Date? {
    guard let data = get(for: key.rawValue) else { return nil }
    return Date(timeIntervalSince1970: data.to(type: TimeInterval.self))
  }
  
  func setDate(_ value: Date?, for key: KeychainKeys) {
    guard let value = value else {
      set(nil, for: key.rawValue)
      return
    }
    let data = Data(from: value.timeIntervalSince1970)
    set(data, for: key.rawValue)
  }
  
  // MARK: - Int
  func getInt(key: KeychainKeys) -> Int? {
    let data = get(for: key.rawValue)
    return data?.to(type: Int.self)
  }
  
  func setInt(_ value: Int?, for key: KeychainKeys) {
    guard let value = value else {
      set(nil, for: key.rawValue)
      return
    }
    let data = Data(from: value)
    set(data, for: key.rawValue)
  }
  
  // MARK: - Helpers
  func exist(_ key: KeychainKeys) -> Bool {
    return get(for: key.rawValue) != nil
  }
  
}
