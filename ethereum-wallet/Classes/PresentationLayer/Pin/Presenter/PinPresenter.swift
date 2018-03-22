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
    interactor.getPinInfo()
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
  
  func didReceivePinInfo(_ info: PinInfo) {
    view.didReceivePinInfo(info)
  }
  
  func didPreformPostProccess() {
    view.didSucceed()
    onSuccess(self.view.viewController)
  }
  
  func didFailedPostProcess(with error: Error) {
    view.didFailed()
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - PinModuleInput

extension PinPresenter: PinModuleInput {
  
  func present(from viewController: UIViewController, onSuccess: @escaping (UIViewController) -> Void) {
    view.present(fromViewController: viewController)
  }
  
}


// MARK: - PinServiceDelegate

extension PinPresenter: PinServiceDelegate {
 
  func pinLockDidSucceed(_ lock: PinServiceProtocol, acceptedPin pin: [String]) {
    interactor.performPostProcess(with: pin)
  }
  
  func pinLockDidFail(_ lock: PinServiceProtocol) {
    view.didFailed()
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
  }
  
  func pinLockDidChangeState(_ lock: PinServiceProtocol) {
    interactor.getPinInfo()
    view.didChangeState()
  }
  
  func pinLock(_ lock: PinServiceProtocol, addedSignAtIndex index: Int) {
    view.didAddSignAtIndex(index)
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
  }
  
  func pinLock(_ lock: PinServiceProtocol, removedSignAtIndex index: Int) {
    view.didRemoveSignAtIndex(index)
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
  }
  
  
}
