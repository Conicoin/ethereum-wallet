//
//  SetPasscodeState.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

struct SetPasscodeState: PasscodeStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let isTouchIDAllowed: Bool
  
  init(title: String) {
    self.title = title
    self.isCancellableAction = true
    self.isTouchIDAllowed = false
  }
  
  init() {
    self.init(title: Localized.passcodeSetTitle())
  }
  
  func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeServiceProtocol) {
    let nextState = ConfirmPasscodeState(passcode: passcode)
    lock.changeStateTo(nextState)
  }
}
