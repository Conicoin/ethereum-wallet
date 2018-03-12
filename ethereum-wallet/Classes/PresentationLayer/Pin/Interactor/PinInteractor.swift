//
//  PinPinInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

typealias PasscodeInfo = (title: String, isCancellable: Bool, isTouchIDAllowed: Bool)

class PinInteractor {
  weak var output: PinInteractorOutput!
  
  var passcodeService: PasscodeServiceProtocol!
}


// MARK: - PinInteractorInput

extension PinInteractor: PinInteractorInput {
  
  func getPasscodeInfo() {
    let info = (
      title: passcodeService.lockState.title,
      isCancellable: passcodeService.lockState.isCancellableAction,
      isTouchIDAllowed: passcodeService.isTouchIDAllowed
    )
    output.didReceivePasscodeInfo(info)
  }
  
  func didAddSign(_ sign: String) {
    passcodeService.addSign(sign)
  }
  
  func didDeleteSign() {
    passcodeService.removeSign()
  }

}
