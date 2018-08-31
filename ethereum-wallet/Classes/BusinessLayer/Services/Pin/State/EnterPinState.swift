// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

public let PinLockIncorrectPinNotification = "pin.lock.incorrect.pin.notification"

struct EnterPinState: PinStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let touchIdReason: String?
  let isTermsShown: Bool
  
  private var inccorectPinAttempts = 0
  private var isNotificationSent = false
  
  init(allowCancellation: Bool, title: String, touchIdReason: String?) {
    self.title = title
    self.touchIdReason = touchIdReason
    self.isCancellableAction = allowCancellation
    self.isTermsShown = false
  }
  
  mutating func acceptPin(_ pin: [String], fromLock lock: PinServiceProtocol) {
    guard let currentPin = lock.repository.pin else {
      return
    }
    
    if pin == currentPin {
      lock.delegate?.pinLockDidSucceed(lock, acceptedPin: pin)
    } else {
      inccorectPinAttempts += 1
      if inccorectPinAttempts >= lock.configuration.maximumInccorectPinAttempts {
        postNotification()
      }
      lock.delegate?.pinLockDidFail(lock)
    }
  }
  
  private mutating func postNotification() {
    guard !isNotificationSent else { return }
    let name = NSNotification.Name(rawValue: PinLockIncorrectPinNotification)
    NotificationCenter.default.post(name: name, object: nil)
    isNotificationSent = true
  }
}
