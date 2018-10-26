// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class TokenDetailsModule {
    
  class func create(app: Application) -> TokenDetailsModuleInput {
    let router = TokenDetailsRouter()
    let presenter = TokenDetailsPresenter()
    let interactor = TokenDetailsInteractor()
    let viewController = R.storyboard.tokenDetails.tokenDetailsViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app
    
    // Injection
    interactor.transactionsDataStoreService = TransactionsDataStoreService()
        
    return presenter
  }
    
}
