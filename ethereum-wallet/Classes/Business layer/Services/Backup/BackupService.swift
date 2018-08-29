// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class BackupService: BackupServiceProtocol {
  
  let keychain: Keychain
  let accountService: AccountServiceProtocol
  
  private let unlockPeriod: TimeInterval = 1200
  private var lastUnlockDate: Date = Date()
  
  init(keychain: Keychain, accountService: AccountServiceProtocol) {
    self.keychain = keychain
    self.accountService = accountService
  }

  func autobackup() {
    if shouldBackup() {
      backup()
    }
  }
  
  // MARK: Privates
  
  private func shouldBackup() -> Bool {
    guard lastUnlockDate.addingTimeInterval(unlockPeriod) < Date() else {
      return false
    }
    guard !keychain.isLocked else {
      return false
    }
    guard let account = accountService.currentAccount else {
      return false
    }
    guard account.type == .mnemonic else {
      return false
    }
    guard !keychain.isHdWalletBackuped else {
      return false
    }
    return true
  }
  
  private func backup() {
    let rootViewContoller = AppDelegate.currentWindow.rootViewController!
    MnemonicModule.create().presentModal(from: rootViewContoller, state: .backup) { vc in
      vc.dismiss(animated: true, completion: nil)
    }
  }

}
