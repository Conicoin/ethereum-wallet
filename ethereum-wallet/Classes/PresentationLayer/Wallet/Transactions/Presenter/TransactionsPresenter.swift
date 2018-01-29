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
  
  var filteredTransactions = [TransactionDisplayable]()
  
  private var transactions = [TransactionDisplayable]() {
    didSet {
      filterTransactions()
    }
  }
  private var tokenTransactions = [TransactionDisplayable]() {
    didSet {
      filterTransactions()
    }
  }
  
  private func filterTransactions() {
    let joined: [TransactionDisplayable] = Array([transactions, tokenTransactions].joined())
    filteredTransactions = joined.sorted { $0.timestamp > $1.timestamp }
    view.didReceiveTransactions()
  }
  
}


// MARK: - TransactionsViewOutput

extension TransactionsPresenter: TransactionsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    interactor.getTransactions()
    interactor.getTokenTransactions()
  }
  
  func viewIsAppear() {
    interactor.updateTransactions()
    interactor.updateTokenTransactions()
  }
  
  func didRefresh() {
    interactor.updateTransactions()
    interactor.updateTokenTransactions()
  }

}


// MARK: - TransactionsInteractorOutput

extension TransactionsPresenter: TransactionsInteractorOutput {
  
  func didReceiveTransactions(_ transactions: [Transaction]) {
    self.transactions = transactions
  }
  
  func didReceiveTokenTransactions(_ transactions: [TokenTransaction]) {
    self.tokenTransactions = transactions
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
