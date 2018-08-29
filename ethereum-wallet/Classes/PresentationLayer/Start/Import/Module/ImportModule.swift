// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

enum ImportState {
  case jsonKey
  case privateKey
  case mnemonic
}

class ImportModule {
    
  class func create(with state: ImportState) -> ImportModuleInput {
    let router = ImportRouter()
    let presenter = ImportPresenter()
    let interactor = ImportInteractor()
    let viewController = R.storyboard.import.importViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // MARK: Injection
    
    interactor.keychain = Keychain()
    interactor.walletManager = WalletManagerFactory().create()

    let mnemonicService = MnemonicService()
    interactor.verificator = ImportVerificatorFactory(mnemonicService: mnemonicService).create(state)
    presenter.state = ImportStateFactory(state: state).create()
        
    return presenter
  }
    
}
