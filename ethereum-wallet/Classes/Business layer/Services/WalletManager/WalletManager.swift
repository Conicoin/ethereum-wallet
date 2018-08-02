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
  let mnemonicService: MnemonicServiceProtocol
  
  init(walletDataStoreService: WalletDataStoreServiceProtocol, coinDataStoreService: CoinDataStoreServiceProtocol, keystoreService: KeystoreServiceProtocol, mnemonicService: MnemonicServiceProtocol) {
    self.walletDataStoreService = walletDataStoreService
    self.coinDataStoreService = coinDataStoreService
    self.keystoreService = keystoreService
    self.mnemonicService = mnemonicService
  }
  
  func createWallet(passphrase: String) throws {
    let gethAccount = try keystoreService.createAccount(passphrase: passphrase)
    let jsonKey = try keystoreService.jsonKey(for: gethAccount, passphrase: passphrase)
    
    let keyObject = try JSONDecoder().decode(Key.self, from: jsonKey)
    let privateKey = try keyObject.decrypt(password: passphrase)
    
    let address = gethAccount.getAddress().getHex()!
        
    let account = Account(type: .privateKey, address: address, key: privateKey.hex())
    let keychain = Keychain()
    keychain.accounts = [account]
    keychain.passphrase = passphrase
    
    commonWalletInitialization(address: address)
  }
  
  func importWallet(jsonKey: Data, passphrase: String) throws {
    let gethAccount = try keystoreService.restoreAccount(with: jsonKey, passphrase: passphrase)
    
    let keyObject = try JSONDecoder().decode(Key.self, from: jsonKey)
    let privateKey = try keyObject.decrypt(password: passphrase)
    
    let address = gethAccount.getAddress().getHex()!
    let account = Account(type: .privateKey, address: address, key: privateKey.hex())
    let keychain = Keychain()
    keychain.accounts = [account]
    keychain.passphrase = passphrase
    
    commonWalletInitialization(address: address)
  }
  
  func importWallet(privateKey: Data, passphrase: String) throws {
    let gethAccount = try keystoreService.restoreAccount(withECDSA: privateKey, passphrase: passphrase)
    
    let address = gethAccount.getAddress().getHex()!
    let account = Account(type: .privateKey, address: address, key: privateKey.hex())
    let keychain = Keychain()
    keychain.accounts = [account]
    keychain.passphrase = passphrase
    
    commonWalletInitialization(address: address)
  }
  
  func importWallet(mnemonic: [String], passphrase: String) throws {
    let seed = try mnemonicService.createSeed(mnemonic: mnemonic, withPassphrase: "")
    let chain = Chain.mainnet
    let masterPrivateKey = HDPrivateKey(seed: seed, network: chain)
    let privateKey = try masterPrivateKey
      .derived(at: 44, hardens: true)
      .derived(at: chain.bip44CoinType, hardens: true)
      .derived(at: 0, hardens: true)
      .derived(at: 0)
      .derived(at: 0).privateKey()
    
    let gethAccount = try keystoreService.restoreAccount(withECDSA: privateKey.raw, passphrase: passphrase)
    
    let address = gethAccount.getAddress().getHex()!
    let account = Account(type: .mnemonic, address: address, key: mnemonic.joined(separator: " "))
    
    let keychain = Keychain()
    keychain.accounts = [account]
    keychain.passphrase = passphrase
    
    commonWalletInitialization(address: address)
  }
  
  // MARK: - Privates
  
  private func commonWalletInitialization(address: String) {
    walletDataStoreService.createWallet(address: address)
    coinDataStoreService.createCoin()
  }
  
}
