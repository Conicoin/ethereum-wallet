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
  
  private func getTransactionsFromNetwork(address: String) {
    interactor.loadTransactions(address: address)
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
    guard let wallet = wallet else { return }
    getTransactionsFromNetwork(address: wallet.address)
  }
  
  func didRefresh() {
    guard let wallet = wallet else { return }
    getTransactionsFromNetwork(address: wallet.address)
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
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.wallet = wallet
    getTransactionsFromNetwork(address: wallet.address)
  }
  
  func didReceiveSections(_ sections: [Date : [TransactionDisplayer]], sortedSections: [Date]) {
    view.didReceiveSections(sections, sortedSections: sortedSections)
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
