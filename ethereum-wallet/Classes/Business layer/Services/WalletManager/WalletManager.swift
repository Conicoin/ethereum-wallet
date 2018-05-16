//
//  WalletConfigurator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletManager: WalletManagerProtocol {
  
  let walletDataStoreService: WalletDataStoreServiceProtocol
  let coinDataStoreService: CoinDataStoreServiceProtocol
  let keystoreService: KeystoreServiceProtocol
  
  init(walletDataStoreService: WalletDataStoreServiceProtocol, coinDataStoreService: CoinDataStoreServiceProtocol, keystoreService: KeystoreServiceProtocol) {
    self.walletDataStoreService = walletDataStoreService
    self.coinDataStoreService = coinDataStoreService
    self.keystoreService = keystoreService
  }
  
  func createWallet(passphrase: String) throws {
    let account = try keystoreService.createAccount(passphrase: passphrase)
    let jsonKey = try keystoreService.jsonKey(for: account, passphrase: passphrase)
    
    let keychain = Keychain()
    keychain.jsonKey = jsonKey
    keychain.passphrase = passphrase
    
    let address = account.getAddress().getHex()!
    commonWalletInitialization(address: address)
  }
  
  func importWallet(jsonKey: Data, passphrase: String) throws {
    let account = try keystoreService.restoreAccount(with: jsonKey, passphrase: passphrase)
    
    let keychain = Keychain()
    keychain.jsonKey = jsonKey
    keychain.passphrase = passphrase
    
    let address = account.getAddress().getHex()!
    commonWalletInitialization(address: address)
  }
  
  func importWallet(privateKey: Data, passphrase: String) throws {
    let account = try keystoreService.restoreAccount(withECDSA: privateKey, passphrase: passphrase)
    
    let keychain = Keychain()
    keychain.jsonKey = privateKey
    keychain.passphrase = passphrase
    
    let address = account.getAddress().getHex()!
    commonWalletInitialization(address: address)
  }
  
  // MARK: - Privates
  
  private func commonWalletInitialization(address: String) {
    walletDataStoreService.createWallet(address: address)
    coinDataStoreService.createCoin()
    Defaults.isWalletCreated = true
  }
  
}
