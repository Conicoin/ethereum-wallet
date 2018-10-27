// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class BalancePresenter {
    
  weak var view: BalanceViewInput!
  weak var output: BalanceModuleOutput?
  var interactor: BalanceInteractorInput!
  var router: BalanceRouterInput!
  var balance: BalanceViewModel?
  
  var selectedCurrency = Constants.Wallet.defaultCurrency
}


// MARK: - BalanceViewOutput

extension BalancePresenter: BalanceViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    interactor.startBalanceUpdater()
    interactor.startRatesUpdater()
    interactor.getBalance()
    interactor.getTokens()
    interactor.getWallet()

  }
  
  func viewIsAppear() {
  }
  
  func didSendPressed() {
    guard let balance = balance else { return }
    let coin = Coin(balance: balance.currency)
    router.presentSend(for: coin, from: viewController)
  }
  
  func didReceivePressed() {
    router.presentReceive(from: view.viewController)
  }
  
  
  func didSelectToken(_ viewModel: TokenViewModel) {
    router.presentDetails(for: viewModel, from: view.viewController)
  }
  
  func didRefresh() {
    interactor.updateBalance()
  }
  
  func didBalanceViewPressed() {
    let list = Constants.Wallet.supportedCurrencies
    guard let index = list.index(of: selectedCurrency) else { return }
    selectedCurrency = list[(index + 1) % list.count]
    
    guard let balance = balance else { return }
    view.setTotalTokenAmount(selectedCurrency)
    view.setPreviewTitle(selectedCurrency, balance: balance)
  }

}


// MARK: - BalanceInteractorOutput

extension BalancePresenter: BalanceInteractorOutput {
 
  func didReceiveWallet(_ wallet: Wallet) {
    self.selectedCurrency = wallet.localCurrency
    view.setTotalTokenAmount(wallet.localCurrency)
  }
  
  func didReceiveBalance(_ balance: BalanceViewModel) {
    self.balance = balance
    view.setBalance(balance)
  }
  
  func didReceiveTokens(_ viewModels: [TokenViewModel]) {
    view.endRefreshing()
    view.setTokens(viewModels)
    view.setTotalTokenAmount(selectedCurrency)
  }
  
  func didFailedWalletReceiving(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
    view.endRefreshing()
  }
  
  func didFailedTokensReceiving(with error: Error) {
    view.endRefreshing()
  }

}


// MARK: - BalanceModuleInput

extension BalancePresenter: BalanceModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }
}
