// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

extension Keychain {
  
  enum KeychainKeys: String, EnumCollection {
    case jsonKey = "json_key_data"
    case passphrase = "passphrase"
    case isLocked = "is_locked"
    case currenctAccount = "currenct_account"
    case accounts = "accounts"
    case hdWalletBackuped = "hd_wallet_backuped"
  }
  
  var isAccountBackuped: Bool {
    return exist(.jsonKey)
  }
  
  var currentAccount: Int {
    get {
      return getInt(key: .currenctAccount) ?? 0
    }
    set {
      setInt(newValue, for: .currenctAccount)
    }
  }
  
  var accounts: [Account] {
    get {
      guard
        let data = getData(key: .accounts),
        let accounts = try? JSONDecoder().decode([Account].self, from: data) else {
          return []
      }
      return accounts
    }
    set {
      guard let data = try? JSONEncoder().encode(newValue) else {
        fatalError("Cannot encode new account value")
      }
      setData(data, for: .accounts)
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
  
  var isHdWalletBackuped: Bool {
    get {
      return getBool(for: .hdWalletBackuped)
    }
    set {
      setBool(newValue, for: .hdWalletBackuped)
    }
  }
  
  // MARK: - Getters

  
  func getPassphrase() throws -> String {
    guard let passphrase = passphrase else {
      throw KeychainError.noPassphrase
    }
    return passphrase
  }
  
  var isAuthorized: Bool {
    return passphrase != nil && !accounts.isEmpty
  }
  
  // MARK: - Utils
  
  func deleteAll() {
    for key in KeychainKeys.allValues {
      delete(for: key.rawValue)
    }
  }
  
}

