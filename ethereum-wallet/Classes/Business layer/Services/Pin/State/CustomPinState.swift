// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

struct CustomPinState: PinStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let touchIdReason: String?
  let isTermsShown: Bool
  
  init(allowCancellation: Bool, touchIdReason: String?, title: String, isTermsShown: Bool) {
    self.title = title
    self.touchIdReason = touchIdReason
    self.isCancellableAction = allowCancellation
    self.isTermsShown = isTermsShown
  }
  
  mutating func acceptPin(_ pin: [String], fromLock lock: PinServiceProtocol) {
    lock.delegate?.pinLockDidSucceed(lock, acceptedPin: pin)
  }
  
}
