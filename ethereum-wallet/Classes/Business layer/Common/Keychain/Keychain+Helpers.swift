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

extension Keychain {
  
  enum KeychainKeys: String {
    case jsonKey = "json_key_data"
    case firstEnterDate = "firstEnterDate"
    case firstEnterBlock = "firstEnterBlock"
    case passphrase = "passphrase"
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
  
  var firstEnterBlock: Int? {
    get {
      return getInt(key: .firstEnterBlock)
    }
    set {
      setInt(newValue, for: .firstEnterBlock)
    }
  }
  
  var firstEnterDate: Date? {
    get {
      return getDate(key: .firstEnterDate)
    }
    
    set {
      setDate(newValue, for: .firstEnterDate)
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
  
}

