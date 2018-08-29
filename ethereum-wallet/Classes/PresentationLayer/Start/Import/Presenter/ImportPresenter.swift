// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ImportPresenter {
    
  weak var view: ImportViewInput!
  weak var output: ImportModuleOutput?
  var interactor: ImportInteractorInput!
  var router: ImportRouterInput!
  var state: ImportStateProtocol!
    
}


// MARK: - ImportViewOutput

extension ImportPresenter: ImportViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.setState(state)
  }
  
  func didConfirmKey(_ key: String) {
    interactor.verifyKey(key)
  }
  
  func closeDidPressed() {
    view.dissmissModal()
  }

}


// MARK: - ImportInteractorOutput

extension ImportPresenter: ImportInteractorOutput {
  
  func didConfirmValidKey(_ key: WalletKey) {
    router.presentPin(from: view.viewController, key: key) { [unowned self] pin, routing in
      self.interactor.importKey(key, passcode: pin, completion: routing)
    }
  }
  
  func didFailed(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - ImportModuleInput

extension ImportPresenter: ImportModuleInput {
  
  func present(from viewController: UIViewController) {
    view.present(fromViewController: viewController)
  }

}
