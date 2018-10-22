// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit
import RealmSwift

class TransactionsPresenter {
  
  weak var view: TransactionsViewInput!
  weak var output: TransactionsModuleOutput?
  var interactor: TransactionsInteractorInput!
  var router: TransactionsRouterInput!
}


// MARK: - TransactionsViewOutput

extension TransactionsPresenter: TransactionsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.getTransactions()
  }
  
  func viewIsAppear() {

  }
  
  func didRefresh() {
    interactor.updateTransactions()
  }
  
  func didTransactionPressed(_ txIndex: TransactionDisplayer) {
    guard let tabBarController = view.viewController.tabBarController else {
      return
    }
    router.presentDetails(with: txIndex, from: tabBarController)
  }

}


// MARK: - TransactionsInteractorOutput

extension TransactionsPresenter: TransactionsInteractorOutput {
  
  func didReceiveTransactions(_ transactions: [TransactionDisplayer]) {
    view.stopRefreshing()
    view.setTransactions(transactions)
  }
  
  func didFailedTransactionsReceiving(with error: Error) {
    view.stopRefreshing()
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - TransactionsModuleInput

extension TransactionsPresenter: TransactionsModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }

}
