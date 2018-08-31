// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class WalletManager: WalletManagerProtocol {
  
  let keychain: Keychain
  let walletDataStoreService: WalletDataStoreServiceProtocol
  let coinDataStoreService: CoinDataStoreServiceProtocol
  let keystoreService: KeystoreServiceProtocol
  let mnemonicService: MnemonicServiceProtocol
  
  init(keyhcain: Keychain,
       walletDataStoreService: WalletDataStoreServiceProtocol,
       coinDataStoreService: CoinDataStoreServiceProtocol,
       keystoreService: KeystoreServiceProtocol,
       mnemonicService: MnemonicServiceProtocol) {
    self.walletDataStoreService = walletDataStoreService
    self.coinDataStoreService = coinDataStoreService
    self.keystoreService = keystoreService
    self.mnemonicService = mnemonicService
    self.keychain = keyhcain
  }
  
  func createWallet(passphrase: String) throws {
    let mnemonic = mnemonicService.create(strength: .normal, language: .english)
    try importWallet(mnemonic: mnemonic, passphrase: passphrase)
  }
  
  func importWallet(jsonKey: Data, passphrase: String) throws {
    let gethAccount = try keystoreService.restoreAccount(with: jsonKey, passphrase: passphrase)
    
    let keyObject = try JSONDecoder().decode(Key.self, from: jsonKey)
    let privateKey = try keyObject.decrypt(password: passphrase)
    
    let address = gethAccount.getAddress().getHex()!
    let account = Account(type: .privateKey, address: address, key: privateKey.hex())
    keychain.accounts = [account]
    keychain.passphrase = passphrase
    
    commonWalletInitialization(address: address)
  }
  
  func importWallet(privateKey: Data, passphrase: String) throws {
    let gethAccount = try keystoreService.restoreAccount(withECDSA: privateKey, passphrase: passphrase)
    
    let address = gethAccount.getAddress().getHex()!
    let account = Account(type: .privateKey, address: address, key: privateKey.hex())
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
