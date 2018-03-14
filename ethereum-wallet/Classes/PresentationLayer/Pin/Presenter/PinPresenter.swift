//
//  PinPinPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class PinPresenter {
    
  weak var view: PinViewInput!
  weak var output: PinModuleOutput?
  var interactor: PinInteractorInput!
  var router: PinRouterInput!
  
  private var onSuccess: ((UIViewController) -> Void)!
}


// MARK: - PinViewOutput

extension PinPresenter: PinViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    interactor.getPasscodeInfo()
  }
  
  func didAddSign(_ sign: String) {
    interactor.didAddSign(sign)
  }
  
  func didDeleteSign() {
    interactor.didDeleteSign()
  }

}


// MARK: - PinInteractorOutput

extension PinPresenter: PinInteractorOutput {
  
  func didReceivePasscodeInfo(_ info: PasscodeInfo) {
    view.didReceivePasscodeInfo(info)
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - PinModuleInput

extension PinPresenter: PinModuleInput {
  
  func present(from viewController: UIViewController, onSuccess: @escaping (UIViewController) -> Void) {
    self.onSuccess = onSuccess
    view.present(fromViewController: viewController)
  }
  
}


// MARK: - PasscodeServiceDelegate

extension PinPresenter: PasscodeServiceDelegate {
 
  func passcodeLockDidSucceed(_ lock: PasscodeServiceProtocol) {
    view.didSucceed()
    interactor.performPostProcess()
    onSuccess(self.view.viewController)
  }
  
  func passcodeLockDidFail(_ lock: PasscodeServiceProtocol) {
    view.didFailed()
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
  }
  
  func passcodeLockDidChangeState(_ lock: PasscodeServiceProtocol) {
    interactor.getPasscodeInfo()
    view.didChangeState()
  }
  
  func passcodeLock(_ lock: PasscodeServiceProtocol, addedSignAtIndex index: Int) {
    view.didAddSignAtIndex(index)
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
  }
  
  func passcodeLock(_ lock: PasscodeServiceProtocol, removedSignAtIndex index: Int) {
    view.didRemoveSignAtIndex(index)
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
  }
  
  
}
