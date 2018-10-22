// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class TransactionsModule {
    
  class func create(app: Application) -> TransactionsModuleInput {
    let router = TransactionsRouter()
    let presenter = TransactionsPresenter()
    let interactor = TransactionsInteractor()
    let viewController = R.storyboard.transactions.transactionsViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app
    
    // MARK: - Injection
    
    interactor.transactionRepository = app.transactionRepository
    interactor.balanceUpdater = app.balanceUpdater
    
    return presenter
  }
    
}
