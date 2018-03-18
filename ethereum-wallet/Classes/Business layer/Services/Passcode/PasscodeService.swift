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

class PasscodeService: PasscodeServiceProtocol {
  
  weak var delegate: PasscodeServiceDelegate?
  
  let configuration: PasscodeConfigurationProtocol
  let repository: PasscodeRepositoryProtocol
  var lockState: PasscodeStateProtocol
  
  private lazy var passcode = [String]()
  
  init(state: PasscodeStateProtocol, configuration: PasscodeConfigurationProtocol) {
    precondition(configuration.passcodeLength > 0, "Passcode length sould be greather than zero.")
    self.lockState = state
    self.configuration = configuration
    self.repository = configuration.repository
  }
  
  var isTouchIDAllowed: Bool {
    return isTouchIDEnabled() && configuration.isTouchIDAllowed && lockState.isTouchIDAllowed
  }
  
  func addSign(_ sign: String) {
    passcode.append(sign)
    delegate?.passcodeLock(self, addedSignAtIndex: passcode.count - 1)
    
    let deadlineTime = DispatchTime.now() + .milliseconds(200)
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
      if self.passcode.count >= self.configuration.passcodeLength {
        self.lockState.acceptPasscode(self.passcode, fromLock: self)
        self.passcode.removeAll(keepingCapacity: true)
      }
    }
  }
  
  func removeSign() {
    guard passcode.count > 0 else { return }
    passcode.removeLast()
    delegate?.passcodeLock(self, removedSignAtIndex: passcode.count)
  }
  
  func changeStateTo(_ state: PasscodeStateProtocol) {
    lockState = state
    delegate?.passcodeLockDidChangeState(self)
  }
  
  func authenticateWithBiometrics() {
    guard isTouchIDAllowed else { return }
    let context = LAContext()
    let reason = Localized.passcodeTouchIDButton()
    context.localizedFallbackTitle = Localized.passcodeTouchIDButton()
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
      success, error in
      self.handleTouchIDResult(success)
    }
  }
  
  private func handleTouchIDResult(_ success: Bool) {
    DispatchQueue.main.async {
      if success {
        guard let passcode = self.repository.passcode else {
          return
        }
        self.delegate?.passcodeLockDidSucceed(self, acceptedPasscode: passcode)
      }
    }
  }
  
  private func isTouchIDEnabled() -> Bool {
    let context = LAContext()
    return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
  }
}

