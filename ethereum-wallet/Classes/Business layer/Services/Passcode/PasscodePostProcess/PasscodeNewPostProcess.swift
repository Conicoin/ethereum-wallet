//
//  PasscodeNewPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeNewPostProcess: PasscodePostProcessProtocol {
  
  let onSuccess: () -> Void
  let keystoreService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(onSuccess: @escaping () -> Void, keystoreService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.onSuccess = onSuccess
    self.keystoreService = keystoreService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func perform(with passphrase: String) throws {
    let account = try keystoreService.createAccount(passphrase: passphrase)
    let jsonKey = try keystoreService.jsonKey(for: account, passphrase: passphrase)
    let keychain = Keychain()
    keychain.jsonKey = jsonKey
    keychain.passphrase = passphrase
    let address = account.getAddress().getHex()!
    walletDataStoreService.createWallet(address: address)
    Defaults.isWalletCreated = true
    onSuccess()
  }

}
