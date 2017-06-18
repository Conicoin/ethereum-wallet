//
//  EthereumAccountService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


// MARK: - EthereumAccountDelegate

protocol EthereumAccountDelegate {
    func success(account: Account)
    func didFailed(with error: Error)
}

struct EthereumAccountService {
    
    var delegate: EthereumAccountDelegate
    
    init(delegate: EthereumAccountDelegate) {
        self.delegate = delegate
    }
    
    func createAccount(passphrase: String) {
        do {
            NSLog("4")
            let account = try Ethereum.core.createAccount(passphrase: passphrase)
            NSLog("5")
            let jsonKey = try Ethereum.core.jsonKey(for: account, passphrase: passphrase)
            NSLog("6")
            try Keychain.set(jsonKey, for: Constants.Keychain.jsonKey)
            NSLog("7")
            delegate.success(account: Account(address: account.getAddress().getHex()))
            NSLog("8")
        } catch {
            NSLog("9")
            delegate.didFailed(with: error)
        }
    }
    
    func restoreAccount(passphrase: String) {
        do {
            NSLog("10")
            let jsonKey = try Keychain.get(for: Constants.Keychain.jsonKey)
            NSLog("11")
            let account = try Ethereum.core.restoreAccount(with: jsonKey, passphrase: passphrase)
            NSLog("12")
            delegate.success(account: Account(address: account.getAddress().getHex()))
            NSLog("13")
        } catch {
            NSLog("14")
            delegate.didFailed(with: error)
        }
    }

}
