// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

protocol KeystoreServiceProtocol {
  var keystoreUrl: String { get }
  func getAccount(at index: Int) throws -> GethAccount
  func createAccount(passphrase: String) throws -> GethAccount
  func jsonKey(for account: GethAccount, passphrase: String) throws -> Data
  func jsonKey(for account: GethAccount, passphrase: String, newPassphrase: String) throws -> Data
  func restoreAccount(with jsonKey: Data, passphrase: String) throws -> GethAccount
  func restoreAccount(withECDSA key: Data, passphrase: String) throws -> GethAccount
  func changePassphrase(_ old: String, new: String) throws
  func deleteAccount(_ account: GethAccount, passphrase: String) throws
  func deleteAllAccounts(passphrase: String) throws
  func signTransaction(_ transaction: GethTransaction, account: GethAccount, passphrase: String, chainId: Int64) throws -> GethTransaction
}
