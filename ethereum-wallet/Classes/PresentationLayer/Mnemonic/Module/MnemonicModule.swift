// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class MnemonicModule {
  
  class func create(app: Application) -> MnemonicModuleInput {
    let router = MnemonicRouter()
    let presenter = MnemonicPresenter()
    let interactor = MnemonicInteractor()
    let viewController = R.storyboard.mnemonic.mnemonicViewController()!
    
    interactor.output = presenter
    
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app
    
    // Injection
    let keychain = Keychain()
    interactor.accountService = AccountService(keychain: keychain)
    interactor.keychain = keychain
    
    return presenter
  }
  
}
