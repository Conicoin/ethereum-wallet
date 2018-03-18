//
//  PasscodeRestoreJsonPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeRestoreJsonPostProcess: PasscodePostProcessProtocol {
  
  let keystoreService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  let key: Data
  
  init(key: Data, keystoreService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.key = key
    self.keystoreService = keystoreService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func perform(with passphrase: String) throws {
    let account = try keystoreService.restoreAccount(with: key, passphrase: passphrase)
    let keychain = Keychain()
    keychain.jsonKey = key
    keychain.passphrase = passphrase
    let address = account.getAddress().getHex()!
    walletDataStoreService.createWallet(address: address)
    Defaults.isWalletCreated = true
  }

}
