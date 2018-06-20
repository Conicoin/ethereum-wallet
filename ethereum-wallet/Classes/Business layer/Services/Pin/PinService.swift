// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General License for
// more details.
//
// You should have received a copy of the GNU General License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import Foundation
import LocalAuthentication

class PinService: PinServiceProtocol {
  
  weak var delegate: PinServiceDelegate?
  
  let configuration: PinConfigurationProtocol
  let repository: PinRepositoryProtocol
  var lockState: PinStateProtocol
  
  private lazy var pin = [String]()
  
  init(state: PinStateProtocol, configuration: PinConfigurationProtocol) {
    precondition(configuration.pinLength > 0, "Pin length sould be greather than zero.")
    self.lockState = state
    self.configuration = configuration
    self.repository = configuration.repository
  }
  
  var isTouchIDAllowed: Bool {
    return isTouchIDEnabled() && configuration.isTouchIDAllowed && lockState.isTouchIDAllowed
  }
  
  func addSign(_ sign: String) {
    pin.append(sign)
    delegate?.pinLock(self, addedSignAtIndex: pin.count - 1)
    
    let deadlineTime = DispatchTime.now() + .milliseconds(200)
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
      if self.pin.count >= self.configuration.pinLength {
        self.lockState.acceptPin(self.pin, fromLock: self)
        self.pin.removeAll(keepingCapacity: true)
      }
    }
  }
  
  func removeSign() {
    guard pin.count > 0 else { return }
    pin.removeLast()
    delegate?.pinLock(self, removedSignAtIndex: pin.count)
  }
  
  func changeStateTo(_ state: PinStateProtocol) {
    lockState = state
    delegate?.pinLockDidChangeState(self)
  }
  
  func authenticateWithBiometrics() {
    guard isTouchIDAllowed else { return }
    let context = LAContext()
    context.localizedFallbackTitle = Localized.pinTouchIDButton()
    
    // iOS 8+ users with Biometric and Custom (Fallback button) verification
    var policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    
    // Depending the iOS version we'll need to choose the policy we are able to use
    if #available(iOS 9.0, *) {
      // iOS 9+ users with Biometric and Passcode verification
      policy = .deviceOwnerAuthentication
    }
    
    var err: NSError?
    guard context.canEvaluatePolicy(policy, error: &err) else { return }
    
    let reason = lockState.touchIdReason ?? Localized.pinTouchIDReason()
    context.evaluatePolicy(policy, localizedReason: reason) {  success, error in
      self.handleTouchIDResult(success)
    }
  }
  
  private func handleTouchIDResult(_ success: Bool) {
    DispatchQueue.main.async {
      if success {
        guard let pin = self.repository.pin else {
          return
        }
        self.delegate?.pinLockDidSucceed(self, acceptedPin: pin)
      }
    }
  }
  
  private func isTouchIDEnabled() -> Bool {
    let context = LAContext()
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
  }
}

