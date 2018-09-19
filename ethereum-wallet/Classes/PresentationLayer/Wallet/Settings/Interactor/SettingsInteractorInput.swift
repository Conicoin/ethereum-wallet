// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation

protocol SettingsInteractorInput: class {
  var biometry: BiometryType { get }
  var passphrase: String { get }
  var accountType: AccountType { get }
  func getWallet()
  func getExportKeyUrl(passcode: String)
  func selectCurrency(_ currency: String)
  func deleteTempBackup(at url: URL)
  func clearAll(passphrase: String, completion: PinResult?)
  func changePin(oldPin: String, newPin: String, completion: PinResult?)
  func unregisterFromRemoteNotifications()
  func registerForRemoteNotifications()
}
