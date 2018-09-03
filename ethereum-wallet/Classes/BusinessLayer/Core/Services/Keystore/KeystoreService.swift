// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

class KeystoreService: KeystoreServiceProtocol {
  
  var keystoreUrl: String {
    let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return documents + "/keystore"
  }
  
  private lazy var keystore: GethKeyStore! = {
    return GethNewKeyStore(keystoreUrl, GethLightScryptN, GethLightScryptP)
  }()
  
  // MARK: Account managment
  
  func getAccount(at index: Int) throws -> GethAccount {
    return try keystore.getAccounts().get(index)
  }
  
  func createAccount(passphrase: String) throws -> GethAccount {
    guard keystore.getAccounts().size() == 0 else {
      throw EthereumError.accountExist
    }
    
    return try keystore.newAccount(passphrase)
  }
  
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data {
    return try keystore.exportKey(account, passphrase: passphrase, newPassphrase: passphrase)
  }
  
  func jsonKey(for account: GethAccount, passphrase: String, newPassphrase: String) throws -> Data {
    return try keystore.exportKey(account, passphrase: passphrase, newPassphrase: newPassphrase)
  }
  
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount  {
    return try keystore.importKey(jsonKey, passphrase: passphrase, newPassphrase: passphrase)
  }
    
  func restoreAccount(withECDSA key: Data, passphrase: String) throws -> GethAccount {
    return try keystore.importECDSAKey(key, passphrase: passphrase)
  }
  
  func changePassphrase(_ old: String, new: String) throws {
    let account = try getAccount(at: 0)
    let oldKey = try jsonKey(for: account, passphrase: old)
    _ = try keystore.importKey(oldKey, passphrase: old, newPassphrase: new)
    try keystore.delete(account, passphrase: old)
  }
  
  func deleteAccount(_ account: GethAccount, passphrase: String) throws {
    return try keystore.delete(account, passphrase: passphrase)
  }
  
  func deleteAllAccounts(passphrase: String) throws {
    let size = keystore.getAccounts().size()
    for i in 0..<size {
      let account = try getAccount(at: i)
      try keystore.delete(account, passphrase: passphrase)
    }
  }
  
  // MARK: Sign transaction
  
  func signTransaction(_ transaction: GethTransaction, account: GethAccount, passphrase: String, chainId: Int64) throws -> GethTransaction {
    let bigChainId = GethBigInt(chainId)
    return try keystore.signTxPassphrase(account, passphrase: passphrase, tx: transaction, chainID: bigChainId)
  }
  
}
