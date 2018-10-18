// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class BalancePresenter {
    
  weak var view: BalanceViewInput!
  weak var output: BalanceModuleOutput?
  var interactor: BalanceInteractorInput!
  var router: BalanceRouterInput!
  var coin: Coin?
  var wallet: Wallet?
  
  var selectedCurrency = Constants.Wallet.defaultCurrency
  
  private func getBalancesFromNetwork(address: String) {
    interactor.getEthereumFromNetwork(address: address)
    interactor.getTokensFromNetwork(address: address)
  }
}


// MARK: - BalanceViewOutput

extension BalancePresenter: BalanceViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    interactor.getCoin()
    interactor.getBalance()
    interactor.getWalletFromDataBase()
    interactor.getTokensFromDataBase()
  }
  
  func viewIsAppear() {
    guard let wallet = wallet else { return }
    getBalancesFromNetwork(address: wallet.address)
  }
  
  func didSendPressed() {
    guard let coin = coin else { return }
    router.presentSend(for: coin, from: viewController)
  }
  
  func didReceivePressed() {
    guard let coin = coin else { return }
    router.presentReceive(for: coin, from: view.viewController)
  }
  
  
  func didSelectToken(_ token: Token) {
    router.presentDetails(for: token, from: view.viewController)
  }
  
  func didRefresh() {
    guard let wallet = wallet else { return }
    getBalancesFromNetwork(address: wallet.address)
  }
  
  func didBalanceViewPressed() {
    let list = Constants.Wallet.supportedCurrencies
    guard let index = list.index(of: selectedCurrency) else { return }
    selectedCurrency = list[(index + 1) % list.count]
    
    guard let coin = coin else { return }
    view.setTotalTokenAmount(selectedCurrency)
    view.setPreviewTitle(selectedCurrency, coin: coin)
  }

}


// MARK: - BalanceInteractorOutput

extension BalancePresenter: BalanceInteractorOutput {
 
  func didReceiveWallet(_ wallet: Wallet) {
    self.wallet = wallet
    getBalancesFromNetwork(address: wallet.address)
    view.setTotalTokenAmount(wallet.localCurrency)
  }
  
  func didReceiveCoin(_ coin: Coin) {
    self.coin = coin
  }

  func didReceiveBalance(_ balance: Currency) {
    view.setBalance(balance)
  }
  
  func didReceiveTokens(_ tokens: [Token]) {
    view.endRefreshing()
    view.setTokens(tokens)
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
