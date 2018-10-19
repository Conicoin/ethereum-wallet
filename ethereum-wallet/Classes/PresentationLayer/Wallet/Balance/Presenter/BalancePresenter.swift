// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class BalancePresenter {
    
  weak var view: BalanceViewInput!
  weak var output: BalanceModuleOutput?
  var interactor: BalanceInteractorInput!
  var router: BalanceRouterInput!
  var coin: CoinViewModel?
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
    interactor.getTokens()
    interactor.getWallet()

  }
  
  func viewIsAppear() {
    guard let wallet = wallet else { return }
    getBalancesFromNetwork(address: wallet.address)
  }
  
  func didSendPressed() {
    guard let coin = coin?.coin else { return }
    router.presentSend(for: coin, from: viewController)
  }
  
  func didReceivePressed() {
    guard let coin = coin?.coin else { return }
    router.presentReceive(for: coin, from: view.viewController)
  }
  
  
  func didSelectToken(_ viewModel: TokenViewModel) {
    router.presentDetails(for: viewModel, from: view.viewController)
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
    self.selectedCurrency = wallet.localCurrency
    view.setTotalTokenAmount(wallet.localCurrency)
  }
  
  func didReceiveCoin(_ viewModel: CoinViewModel) {
    self.coin = viewModel
    view.setCoin(viewModel)
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
