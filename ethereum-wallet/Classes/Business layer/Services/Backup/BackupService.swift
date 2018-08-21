//
//  BackupService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class BackupService: BackupServiceProtocol {
  
  let keychain: Keychain
  let accountService: AccountServiceProtocol
  
  private let unlockPeriod: TimeInterval = 1200
  private var lastUnlockDate: Date = Date.distantPast
  
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
    MnemonicModule.create().presentModal(from: rootViewContoller) { vc in
      vc.dismiss(animated: true, completion: nil)
    }
  }

}
