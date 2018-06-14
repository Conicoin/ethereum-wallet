//
//  LockService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class Locker: LockerProtocol {
  
  private let unlockPeriod: TimeInterval = 60
  private let keychain: Keychain
  
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
