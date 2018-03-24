//
//  PopupTouchPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import LocalAuthentication
import Alamofire

class PopupTouchPostProcess: PopupPostProcessProtocol {
  
  func onConfirm(_ completion: (Result<Bool>) -> Void) {
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
