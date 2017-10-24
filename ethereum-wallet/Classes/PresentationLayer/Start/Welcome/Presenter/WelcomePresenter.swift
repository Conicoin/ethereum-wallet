//
//  WelcomeWelcomePresenter.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 19/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class WelcomePresenter {
    
  weak var view: WelcomeViewInput!
  weak var output: WelcomeModuleOutput?
  var interactor: WelcomeInteractorInput!
  var router: WelcomeRouterInput!
  
  var isRestoring: Bool {
    return Keychain().isAccountBackuped
  }
    
}


// MARK: - WelcomeViewOutput

extension WelcomePresenter: WelcomeViewOutput {

  func viewIsReady() {
    view.setupInitialState(restoring: isRestoring)
  }
  
  func presentPassword() {
    router.presentPassword(from: view.viewController)
  }

}


// MARK: - WelcomeInteractorOutput

extension WelcomePresenter: WelcomeInteractorOutput {

}


// MARK: - WelcomeModuleInput

extension WelcomePresenter: WelcomeModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }

}
