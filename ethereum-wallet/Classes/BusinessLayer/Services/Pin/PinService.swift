// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class PinService: PinServiceProtocol {
  
  weak var delegate: PinServiceDelegate?
  
  let configuration: PinConfigurationProtocol
  let repository: PinRepositoryProtocol
  let biometryService: BiometryServiceProtocol
  var lockState: PinStateProtocol
  
  private lazy var pin = [String]()
  
  init(state: PinStateProtocol, configuration: PinConfigurationProtocol, biometryService: BiometryServiceProtocol) {
    precondition(configuration.pinLength > 0, "Pin length sould be greather than zero.")
    self.lockState = state
    self.configuration = configuration
    self.repository = configuration.repository
    self.biometryService = biometryService
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
    
    let fallback = Localized.pinTouchIDButton()
    let reason = lockState.touchIdReason ?? Localized.pinTouchIDReason()
    biometryService.authenticate(fallback: fallback, reason: reason) { result in
      switch result {
      case .success(let isSuccess):
        self.handleTouchIDResult(isSuccess)
      case .failure(let error):
        print(error.localizedDescription)
      }
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
    return biometryService.isBiometryAvailable
  }
}

