// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

struct NewPinState: PinStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let isTermsShown: Bool
  
  init(title: String) {
    self.title = title
    self.isCancellableAction = true
    self.isTermsShown = true
  }
  
  init() {
    self.init(title: Localized.pinSetTitle())
  }
  
  func acceptPin(_ pin: [String], fromLock lock: PinServiceProtocol) {
    let nextState = ConfirmPinState(pin: pin)
    lock.changeStateTo(nextState)
  }
}
