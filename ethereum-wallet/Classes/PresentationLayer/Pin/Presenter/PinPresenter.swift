//
//  PinPinPresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit
import Alamofire

typealias PinPostProcess = ((String, PinResult?) -> Void)
typealias PinNextScene = ((UIViewController) -> Void)
typealias PinResult = (Result<Any>) -> Void

class PinPresenter {
    
  weak var view: PinViewInput!
  weak var output: PinModuleOutput?
  var interactor: PinInteractorInput!
  var router: PinRouterInput!
  
  private var postProcess: PinPostProcess?
  private var nextScene: PinNextScene?
}


// MARK: - PinViewOutput

extension PinPresenter: PinViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    interactor.getPinInfo()
  }
  
  func viewWillAppear() {
    interactor.authenticateWithBiometrics()
  }
  
  func didAddSign(_ sign: String) {
    interactor.addSign(sign)
  }
  
  func didDeleteSign() {
    interactor.deleteSign()
  }
  
  func didTouchIdPressed() {
    interactor.authenticateWithBiometrics()
  }

}


// MARK: - PinInteractorOutput

extension PinPresenter: PinInteractorOutput {
  
  func didReceivePinInfo(_ info: PinInfo) {
    view.didReceivePinInfo(info)
  }
  
  func didPreformPostProccess() {
    view.didSucceed()
  }
  
  func didFailedPostProcess(with error: Error) {
    view.didFailed()
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - PinModuleInput

extension PinPresenter: PinModuleInput {
  
  func present(from viewController: UIViewController, postProcess: PinPostProcess?, nextScene: PinNextScene?) {
    self.nextScene = nextScene
    self.postProcess = postProcess
    view.present(fromViewController: viewController)
  }
  
  func presentModal(from viewController: UIViewController, postProcess: PinPostProcess?, nextScene: PinNextScene?) {
    self.nextScene = nextScene
    self.postProcess = postProcess
    view.presentModal(fromViewController: viewController)
  }
  
}


// MARK: - PinServiceDelegate

extension PinPresenter: PinServiceDelegate {
 
  func pinLockDidSucceed(_ lock: PinServiceProtocol, acceptedPin pin: [String]) {
    let passcode = pin.joined()
    Loader.start()
    postProcess?(passcode) { result in
      switch result {
      case .success:
        Loader.stop()
        self.nextScene?(self.view.viewController)
      case .failure:
        Loader.stop()
        self.view.viewController.pop()
      }
    }
      
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
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
  }
  
  func pinLock(_ lock: PinServiceProtocol, removedSignAtIndex index: Int) {
    view.didRemoveSignAtIndex(index)
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
  }
  
  
}
