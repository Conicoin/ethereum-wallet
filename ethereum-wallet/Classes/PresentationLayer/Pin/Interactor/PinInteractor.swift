//
//  PinPinInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

typealias PinInfo = (title: String, isCancellable: Bool, isTouchIDAllowed: Bool)

class PinInteractor {
  weak var output: PinInteractorOutput!
  
  var pinService: PinServiceProtocol!
  var pinPostProcess: PinPostProcessProtocol!
}


// MARK: - PinInteractorInput

extension PinInteractor: PinInteractorInput {
  
  func getPinInfo() {
    let info = (
      title: pinService.lockState.title,
      isCancellable: pinService.lockState.isCancellableAction,
      isTouchIDAllowed: pinService.isTouchIDAllowed
    )
    output.didReceivePinInfo(info)
  }
  
  func didAddSign(_ sign: String) {
    pinService.addSign(sign)
  }
  
  func didDeleteSign() {
    pinService.removeSign()
  }
  
  func performPostProcess(with pin: [String]) {
    do {
      try pinPostProcess.perform(with: pin.joined())
      output.didPreformPostProccess()
    } catch {
      output.didFailedPostProcess(with: error)
    }
  }

}
