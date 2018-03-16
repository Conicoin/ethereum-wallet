// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import Foundation

public let PasscodeLockIncorrectPasscodeNotification = "passcode.lock.incorrect.passcode.notification"

struct EnterPasscodeState: PasscodeStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let isTouchIDAllowed: Bool
  
  private var inccorectPasscodeAttempts = 0
  private var isNotificationSent = false
  
  init(allowCancellation: Bool = false, title: String, isTouchIDAllowed: Bool) {
    self.title = title
    self.isTouchIDAllowed = isTouchIDAllowed
    self.isCancellableAction = allowCancellation
  }
  
  mutating func acceptPasscode(_ passcode: [String], fromLock lock: PasscodeServiceProtocol) {
    guard let currentPasscode = lock.repository.passcode else {
      return
    }
    
    if passcode == currentPasscode {
      lock.delegate?.passcodeLockDidSucceed(lock)
    } else {
      inccorectPasscodeAttempts += 1
      if inccorectPasscodeAttempts >= lock.configuration.maximumInccorectPasscodeAttempts {
        postNotification()
      }
      lock.delegate?.passcodeLockDidFail(lock)
    }
  }
  
  private mutating func postNotification() {
    guard !isNotificationSent else { return }
    let name = NSNotification.Name(rawValue: PasscodeLockIncorrectPasscodeNotification)
    NotificationCenter.default.post(name: name, object: nil)
    isNotificationSent = true
  }
}
