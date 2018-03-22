//
//  WalletCreator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletCreator: WalletCreatorProtocol {
  
  let keystoreService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(keystoreService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.keystoreService = keystoreService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func createWallet(with passcode: String) throws {
    let account = try keystoreService.createAccount(passphrase: passcode)
    let jsonKey = try keystoreService.jsonKey(for: account, passphrase: passcode)
    let keychain = Keychain()
    keychain.jsonKey = jsonKey
    keychain.passphrase = passcode
    let address = account.getAddress().getHex()!
    walletDataStoreService.createWallet(address: address)
    Defaults.isWalletCreated = true
  }
  
}
