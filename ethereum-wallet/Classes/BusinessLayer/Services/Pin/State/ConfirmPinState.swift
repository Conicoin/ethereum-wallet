// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

struct ConfirmPinState: PinStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let isTermsShown: Bool
  
  private var pinToConfirm: [String]
  
  init(pin: [String]) {
    self.pinToConfirm = pin
    self.title = Localized.pinConfirmTitle()
    self.isCancellableAction = true
    self.isTermsShown = false
  }
  
  func acceptPin(_ pin: [String], fromLock lock: PinServiceProtocol) {
    if pin == pinToConfirm {
      lock.repository.savePin(pin)
      lock.delegate?.pinLockDidSucceed(lock, acceptedPin: pin)
    } else {
      let mismatchTitle = Localized.pinMismatchTitle()
      let nextState = NewPinState(title: mismatchTitle)
      lock.changeStateTo(nextState)
      lock.delegate?.pinLockDidFail(lock)
    }
  }
}
