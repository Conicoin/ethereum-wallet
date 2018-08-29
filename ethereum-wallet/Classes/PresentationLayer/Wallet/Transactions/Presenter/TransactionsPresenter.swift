// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit
import RealmSwift

class TransactionsPresenter {
  
  weak var view: TransactionsViewInput!
  weak var output: TransactionsModuleOutput?
  var interactor: TransactionsInteractorInput!
  var router: TransactionsRouterInput!
  
  var wallet: Wallet?
  
  let defaultPageLimit = 20
  var currentPage = 0
  
  private func getTransactionsFromNetworkIfAvailable() {
    guard let wallet = wallet else { return }
    interactor.loadTransactions(address: wallet.address, page: currentPage, limit: defaultPageLimit)
  }
  
}


// MARK: - TransactionsViewOutput

extension TransactionsPresenter: TransactionsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.getWallet()
    interactor.getTransactions()
  }
  
  func viewIsAppear() {
    getTransactionsFromNetworkIfAvailable()
  }
  
  func didRefresh() {
    getTransactionsFromNetworkIfAvailable()
  }
  
  func didTransactionPressed(_ txIndex: TransactionDisplayer) {
    guard let tabBarController = view.viewController.tabBarController else {
      return
    }
    router.presentDetails(with: txIndex, from: tabBarController)
  }
    
  func loadNextPage() {
    currentPage += 1
    getTransactionsFromNetworkIfAvailable()
  }

}


// MARK: - TransactionsInteractorOutput

extension TransactionsPresenter: TransactionsInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.wallet = wallet
    getTransactionsFromNetworkIfAvailable()
  }
  
  func didReceiveTransactions(_ transactions: [TransactionDisplayer]) {
    view.setTransactions(transactions)
  }
  
  func didReceiveTransactions() {
    view.stopRefreshing()
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
