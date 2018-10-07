// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class PopupTouchPostProcess: PopupPostProcessProtocol {
  
  let biometryService: BiometryServiceProtocol
  
  init(biometryService: BiometryServiceProtocol) {
    self.biometryService = biometryService
  }
  
  func onConfirm(_ completion: @escaping (Result<Bool>) -> Void) {
    do {
      if try biometryService.canEvaluatePolicy() {
        Defaults.isTouchIDAllowed = true
        completion(.success(true))
      } else {
        completion(.failure(TouchIdError.error(error: nil, biometry: biometryService.biometry)))
      }
    } catch {
      completion(.failure(error))
    }
  }
  
}
