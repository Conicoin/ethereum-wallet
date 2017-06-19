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
            let account = try Ethereum.core.createAccount(passphrase: passphrase)
            let jsonKey = try Ethereum.core.jsonKey(for: account, passphrase: passphrase)
            try Keychain.set(jsonKey, for: Constants.Keychain.jsonKey)
            delegate.success(account: Account(address: account.getAddress().getHex()))
        } catch {
            delegate.didFailed(with: error)
        }
    }
    
    func restoreAccount(passphrase: String) {
        do {
            let jsonKey = try Keychain.get(for: Constants.Keychain.jsonKey)
            let account = try Ethereum.core.restoreAccount(with: jsonKey, passphrase: passphrase)
            delegate.success(account: Account(address: account.getAddress().getHex()))
        } catch {
            delegate.didFailed(with: error)
        }
    }

}
