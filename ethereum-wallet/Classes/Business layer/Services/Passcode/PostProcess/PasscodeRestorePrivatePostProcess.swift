//
//  PasscodeRestorePrivatePostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeRestorePrivatePostProcess: PasscodePostProcessProtocol {
  
  let keystoreService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  let key: Data
  
  init(key: Data, keystoreService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.key = key
    self.keystoreService = keystoreService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func perform(with passphrase: String) throws {
    let keyObject = try Key(privateKey: key, password: passphrase)
    let data = try JSONEncoder().encode(keyObject)
    let account = try keystoreService.restoreAccount(with: data, passphrase: passphrase)
    let keychain = Keychain()
    keychain.jsonKey = key
    keychain.passphrase = passphrase
    let address = account.getAddress().getHex()!
    walletDataStoreService.createWallet(address: address)
    Defaults.isWalletCreated = true
  }

}
