// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class TransactionDetailsModule {

  class func create(isToken: Bool) -> TransactionDetailsModuleInput {
    let router = TransactionDetailsRouter()
    let presenter = TransactionDetailsPresenter()
    let interactor = TransactionDetailsInteractor()
    let viewController = R.storyboard.transactionDetails.transactionDetailsViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor

    return presenter
  }

}
