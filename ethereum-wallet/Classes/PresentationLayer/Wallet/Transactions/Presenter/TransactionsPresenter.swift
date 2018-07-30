// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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
