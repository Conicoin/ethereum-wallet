// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
