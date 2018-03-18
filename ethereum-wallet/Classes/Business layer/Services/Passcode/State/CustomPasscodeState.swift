//
//  CustomPasscodeState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

struct CustomPasscodeState: PasscodeStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let isTouchIDAllowed: Bool
  
  init(allowCancellation: Bool, isTouchIDAllowed: Bool, title: String) {
    self.title = title
    self.isTouchIDAllowed = isTouchIDAllowed
    self.isCancellableAction = allowCancellation
  }
  
  mutating func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeServiceProtocol) {
    lock.delegate?.passcodeLockDidSucceed(lock, acceptedPasscode: passcode)
  }
  
}
