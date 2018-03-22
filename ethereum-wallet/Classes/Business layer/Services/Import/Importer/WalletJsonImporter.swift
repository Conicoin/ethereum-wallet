//
//  WalletJsonImporter.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletJsonImporter: WalletImporterProtocol {
  
  let keystoreService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(keystoreService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.keystoreService = keystoreService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func importKey(_ key: Data, passcode: String) throws {
    let account = try keystoreService.restoreAccount(with: key, passphrase: passcode)
    let keychain = Keychain()
    keychain.jsonKey = key
    keychain.passphrase = passcode
    let address = account.getAddress().getHex()!
    walletDataStoreService.createWallet(address: address)
    Defaults.isWalletCreated = true
  }
  
}
