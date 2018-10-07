// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

typealias PinInfo = (title: String, isCancellable: Bool, isTouchIDAllowed: Bool, biometricImage: String)

class PinInteractor {
  weak var output: PinInteractorOutput!
  
  var pinService: PinServiceProtocol!
}


// MARK: - PinInteractorInput

extension PinInteractor: PinInteractorInput {
  
  func getPinInfo() {
    let info = (
      title: pinService.lockState.title,
      isCancellable: pinService.lockState.isCancellableAction,
      isTouchIDAllowed: pinService.isTouchIDAllowed,
      biometricImage: pinService.biometricImage
    )
    output.didReceivePinInfo(info)
  }
  
  func addSign(_ sign: String) {
    pinService.addSign(sign)
  }
  
  func deleteSign() {
    pinService.removeSign()
  }
  
  func authenticateWithBiometrics() {
    pinService.authenticateWithBiometrics()
  }

}
