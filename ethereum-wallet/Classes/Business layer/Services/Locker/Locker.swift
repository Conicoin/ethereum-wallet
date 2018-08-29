// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class Locker: LockerProtocol {
  
  private let keychain: Keychain
  private let unlockPeriod: TimeInterval = 60
  private var lastUnlockDate: Date = Date.distantPast
  
  init(keychain: Keychain) {
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
    
    let rootViewController = AppDelegate.currentWindow.rootViewController!

    PinModule.create(.lock).presentModal(from: rootViewController, postProcess: { _, postProcess in
      postProcess?(.success(true))
    }) { vc in
      self.keychain.isLocked = false
      self.lastUnlockDate = Date()
      vc.dismiss(animated: true, completion: nil)
    }
  }
  
}
