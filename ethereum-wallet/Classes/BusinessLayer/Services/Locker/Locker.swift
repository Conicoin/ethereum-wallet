// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class Locker: LockerProtocol {

  let app: Application
  let keychain: Keychain
  let unlockPeriod: TimeInterval = 60
  var lastUnlockDate: Date = Date.distantPast
  
  init(app: Application, keychain: Keychain) {
    self.app = app
    self.keychain = keychain
  }
  
  func autolock() {
    if shouldLock() {
      lock()
    }
  }
  
  // MARK: Privates
  
  private func shouldLock() -> Bool {
    if lastUnlockDate.addingTimeInterval(unlockPeriod) < Date() && keychain.passphrase != nil {
      return true
    }
    return false
  }
  
  private func lock() {
    keychain.isLocked = true
    
    guard Defaults.walletCreated else { return }
    
    let rootViewController = AppDelegate.currentWindow.rootViewController!

    PinModule.create(app: app, state: .lock).presentModal(from: rootViewController, postProcess: { _, postProcess in
      postProcess?(.success(true))
    }) { vc in
      self.keychain.isLocked = false
      self.lastUnlockDate = Date()
      vc.dismiss(animated: true, completion: nil)
    }
  }
  
}
