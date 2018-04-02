//
//  TransactionDetailsTransactionDetailsModule.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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

    // MARK: Injection
    if isToken {
      interactor.txStorage = TokenTransactionsDataStoreService()
    } else {
      interactor.txStorage = TransactionsDataStoreService()
    }

    return presenter
  }

}
