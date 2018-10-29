// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

final class Defaults: NSObject {
  
  class var chain: Chain {
    get {
#if TESTNET
      return Chain.rinkeby
#else
      return Chain.mainnet
#endif
    }
  }
  
  class var mode: SyncMode {
    get {
      let raw: Int = get(forKey: .mode, fallback: SyncMode.standard.rawValue)
      return SyncMode(rawValue: raw)!
    }
    
    set {
      set(value: newValue.rawValue, forKey: .mode)
    }
  }
  
  class var isTouchIDAllowed: Bool {
    get {
      return getBool(forKey: .isTouchIDAllowed)
    }
    
    set {
      set(value: newValue, forKey: .isTouchIDAllowed)
    }
  }
  
  class var walletCreated: Bool {
    get {
      return getBool(forKey: .walletCreated)
    }
    
    set {
      set(value: newValue, forKey: .walletCreated)
    }
  }
  
  class func deleteAll() {
    for key in Keys.allCases {
      UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
  }
  
}

private extension Defaults {
  
  enum Keys: String, CaseIterable {
    case chain = "chainKey"
    case mode = "syncMode"
    case walletCreated = "walletCreated"
    case isTouchIDAllowed = "isTouchIDAllowed"
  }
  
  static func set<T: Any>(value: T, forKey key: Keys) {
    UserDefaults.standard.set(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }
  
  static func get<T: Any>(forKey key: Keys, fallback: T) -> T {
    if let value = UserDefaults.standard.value(forKey: key.rawValue) as? T {
      return value
    }
    
    return fallback
  }
  
  static func getBool(forKey key: Keys) -> Bool {
    return UserDefaults.standard.bool(forKey: key.rawValue)
  }
  
}
