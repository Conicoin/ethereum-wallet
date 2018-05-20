//
//  NewPinState.swift
//  PinLock
//
//  Created by Yanko Dimitrov on 8/28/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

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
