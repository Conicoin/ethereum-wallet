//
//  CustomPinState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

struct CustomPinState: PinStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let isTouchIDAllowed: Bool
  
  init(allowCancellation: Bool, isTouchIDAllowed: Bool, title: String) {
    self.title = title
    self.isTouchIDAllowed = isTouchIDAllowed
    self.isCancellableAction = allowCancellation
  }
  
  mutating func acceptPin(_ pin: [String], fromLock lock: PinServiceProtocol) {
    lock.delegate?.pinLockDidSucceed(lock, acceptedPin: pin)
  }
  
}
