//
//  Keychain+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension Keychain {
    
    static var isAccountBackuped: Bool {
        return exist(Constants.Keychain.jsonKey)
    }

}


// MARK: - Keychain hepler bilders

fileprivate extension Keychain {
    
    static func exist(_ key: String) -> Bool {
        return (try? Keychain.get(for: key)) != nil
    }
    
}
