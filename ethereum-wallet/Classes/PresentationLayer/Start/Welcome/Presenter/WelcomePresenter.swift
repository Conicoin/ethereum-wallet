// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class WelcomePresenter {
    
  weak var view: WelcomeViewInput!
  weak var output: WelcomeModuleOutput?
  var interactor: WelcomeInteractorInput!
  var router: WelcomeRouterInput!
  
  var state = WelcomeState.new
    
}


// MARK: - WelcomeViewOutput

extension WelcomePresenter: WelcomeViewOutput {

  func viewIsReady() {
    view.setupInitialState(restoring: state.isRestoring)
  }

  func newDidPressed() {
    switch state {
    case .restore(let account):
      
      router.presentPinRestore(from: view.viewController) { [unowned self] pin, routing in
        switch account.type {
        case .privateKey:
          self.interactor.importPrivateKey(account.key, passcode: pin, completion: routing)
        case .mnemonic:
          self.interactor.importMnemonic(account.key, passcode: pin, completion: routing)
        }
      }
    
    case .new:
      router.presentPinNew(from: view.viewController) { [unowned self] pin, routing in
        self.interactor.createWallet(passcode: pin, completion: routing)
      }
    }
  }
  
  func didImportJsonKeyPressed() {
    router.presentImportJson(from: view.viewController)
  }
  
  func didImportPrivateKeyPressed() {
    router.presentImportPrivate(from: view.viewController)
  }
  
  func didImportMnemonicPressed() {
    router.presentImportMnemonic(from: view.viewController)
  }
  
}


// MARK: - WelcomeInteractorOutput

extension WelcomePresenter: WelcomeInteractorOutput {

}


// MARK: - WelcomeModuleInput

extension WelcomePresenter: WelcomeModuleInput {
  
  func present(state: WelcomeState) {
    self.state = state
    let navigationController = UINavigationController(rootViewController: view.viewController)
    AppDelegate.currentWindow.rootViewController = navigationController
  }

}
