// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
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

extension Keychain {
  
  enum KeychainKeys: String, EnumCollection {
    case jsonKey = "json_key_data"
    case passphrase = "passphrase"
    case isLocked = "is_locked"
  }
  
  var isAccountBackuped: Bool {
    return exist(.jsonKey)
  }
  
  var jsonKey: Data? {
    get {
      return getData(key: .jsonKey)
    }
    set {
      setData(newValue, for: .jsonKey)
    }
  }
    
  var passphrase: String? {
    get {
      return getString(for: .passphrase)
    }
    set {
      setString(newValue, for: .passphrase)
    }
  }
    
  var isLocked: Bool {
    get {
      return getBool(for: .isLocked)
    }
    set {
      setBool(newValue, for: .isLocked)
    }
  }
  
  // MARK: - Getters
  
  func getJsonKey() throws -> Data {
    guard let jsonKey = jsonKey else {
      throw KeychainError.noJsonKey
    }
    return jsonKey
  }
  
  func getPassphrase() throws -> String {
    guard let passphrase = passphrase else {
      throw KeychainError.noPassphrase
    }
    return passphrase
  }
  
  var isAuthorized: Bool {
    return passphrase != nil && jsonKey != nil
  }
  
  // MARK: - Utils
  
  func deleteAll() {
    for key in KeychainKeys.allValues {
      delete(for: key.rawValue)
    }
  }
  
}

