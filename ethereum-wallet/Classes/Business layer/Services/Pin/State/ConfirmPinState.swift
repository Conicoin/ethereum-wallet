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
