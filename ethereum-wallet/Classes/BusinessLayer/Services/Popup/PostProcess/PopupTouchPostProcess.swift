// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import LocalAuthentication

class PopupTouchPostProcess: PopupPostProcessProtocol {
  
  func onConfirm(_ completion: @escaping (Result<Bool>) -> Void) {
    let context = LAContext()
    var error: NSError?
    let isSuccess = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    if isSuccess {
      Defaults.isTouchIDAllowed = true
      completion(.success(true))
    } else {
      completion(.failure(TouchIdError.error(error: error)))
    }
  }
  
}
