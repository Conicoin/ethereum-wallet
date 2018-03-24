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

public let PinLockIncorrectPinNotification = "pin.lock.incorrect.pin.notification"

struct EnterPinState: PinStateProtocol {
  
  let title: String
  let isCancellableAction: Bool
  let touchIdReason: String?
  
  private var inccorectPinAttempts = 0
  private var isNotificationSent = false
  
  init(allowCancellation: Bool, title: String, touchIdReason: String?) {
    self.title = title
    self.touchIdReason = touchIdReason
    self.isCancellableAction = allowCancellation
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
