// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

struct ChangePinState: PinStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let isTermsShown: Bool
  
  init() {
    self.title = Localized.pinChangeTitle()
    self.isCancellableAction = true
    self.isTermsShown = false
  }
  
  func acceptPin(_ pin: [String], fromLock lock: PinServiceProtocol) {
    guard let currentPin = lock.repository.pin else {
      return
    }
    if pin == currentPin {
      let nextState = NewPinState()
      lock.changeStateTo(nextState)
    } else {
      lock.delegate?.pinLockDidFail(lock)
    }
  }
}
