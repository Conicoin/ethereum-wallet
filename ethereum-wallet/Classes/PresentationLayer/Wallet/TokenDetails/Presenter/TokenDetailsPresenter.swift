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


class TokenDetailsPresenter {
    
  weak var view: TokenDetailsViewInput!
  weak var output: TokenDetailsModuleOutput?
  var interactor: TokenDetailsInteractorInput!
  var router: TokenDetailsRouterInput!
  
  var token: Token!
  var selectedCurrency = Constants.Wallet.defaultCurrency
}


// MARK: - TokenDetailsViewOutput

extension TokenDetailsPresenter: TokenDetailsViewOutput {

  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveToken(token)
    interactor.getTransactions(for: token)
  }
  
  func didSendPressed() {
    router.presentSend(for: token, from: view.viewController)
  }
  
  func didBalanceViewPressed() {
    var list = Constants.Wallet.supportedCurrencies
    list.insert(token.balance.iso, at: 0)
    
    guard let index = list.index(of: selectedCurrency) else { return }
    selectedCurrency = list[(index + 1) % list.count]
    
    let fiatBalance = token.fiatLabelString(selectedCurrency)
    view.didReceiveFiatBalance(fiatBalance)
  }
  
  func didTransactionPressed(_ transaction: TransactionDisplayer) {
    router.presentDetails(with: transaction, from: view.viewController)
  }

}


// MARK: - TokenDetailsInteractorOutput

extension TokenDetailsPresenter: TokenDetailsInteractorOutput {
  
  func didReceiveTransactions(_ transactions: [TransactionDisplayer]) {
    view.didReceiveTransactions(transactions)
  }

}


// MARK: - TokenDetailsModuleInput

extension TokenDetailsPresenter: TokenDetailsModuleInput {
  
  func present(with token: Token, from: UIViewController) {
    self.token = token
    self.selectedCurrency = token.balance.iso
    view.present(fromViewController: from)
  }

}
