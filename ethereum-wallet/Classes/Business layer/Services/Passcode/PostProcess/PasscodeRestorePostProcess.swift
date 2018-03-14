//
//  PasscodeRestorePostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeRestorePostProcess: PasscodePostProcessProtocol {
  
  let keystoreService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(keystoreService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.keystoreService = keystoreService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func perform(with passphrase: String) throws {
    let keychain = Keychain()
    let jsonKey = try keychain.getJsonKey()
    let account = try keystoreService.restoreAccount(with: jsonKey, passphrase: passphrase)
    keychain.passphrase = passphrase
    let address = account.getAddress().getHex()!
    walletDataStoreService.createWallet(address: address)
    Defaults.isWalletCreated = true
  }

}
