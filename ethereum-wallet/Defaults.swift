//
//  Defaults.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 01/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

final class Defaults: NSObject {
    
    class var isTestnet: Bool {
        get {
            return get(forKey: .isTestnet, fallback: true)
        }
        
        set {
            set(value: newValue, forKey: .isTestnet)
        }
    }
}

fileprivate extension Defaults {
    
    enum Keys: String {
        case isTestnet = "isTestnetKey"
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
}
