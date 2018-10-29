// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

enum WelcomeState {
  case new
  case restore(account: Account)
  
  var isRestoring: Bool {
    switch self {
    case .new:
      return false
    case .restore:
      return true
    }
  }
}

class WelcomeModule {
    
  class func create(app: Application) -> WelcomeModuleInput {
    let router = WelcomeRouter()
    let presenter = WelcomePresenter()
    let interactor = WelcomeInteractor()
    let viewController = R.storyboard.welcome.welcomeViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app
    
    // MARK: Injection
    
    let walletManager = WalletManagerFactory().create()
    interactor.walletManager = walletManager
    interactor.keystore = KeystoreService()
        
    return presenter
  }
    
}
