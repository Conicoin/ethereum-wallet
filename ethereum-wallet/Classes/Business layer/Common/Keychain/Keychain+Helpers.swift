//
//  Keychain+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension Keychain {
  
  enum KeychainKeys: String {
    case jsonKey = "json_key_data"
    case firstEnterDate = "firstEnterDate"
    case firstEnterBlock = "firstEnterBlock"
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
  
  func getJsonKey() throws -> Data {
    guard let jsonKey = jsonKey else {
      throw KeychainError.noJsonKey
    }
    return jsonKey
  }
  
  var firstEnterDate: Date? {
    get {
      return getDate(key: .firstEnterDate)
    }
    
    set {
      setDate(newValue, for: .firstEnterDate)
    }
  }
  
}

