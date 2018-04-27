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


class BalancePresenter {
    
  weak var view: BalanceViewInput!
  weak var output: BalanceModuleOutput?
  var interactor: BalanceInteractorInput!
  var router: BalanceRouterInput!
  var coin: Coin?
  
  var selectedCurrency = Constants.Wallet.defaultCurrency
}


// MARK: - BalanceViewOutput

extension BalancePresenter: BalanceViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    output?.balanceViewIsReady()
    interactor.getCoinsFromDataBase()
    interactor.getTokensFromDataBase()
    interactor.getWalletFromDataBase()
  }
  
  func viewIsAppear() {
    interactor.getEthereumFromNetwork()
    interactor.getTokensFromNetwork()
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
    interactor.getEthereumFromNetwork()
    interactor.getTokensFromNetwork()
  }
  
  func didBalanceViewPressed() {
    let list = Constants.Wallet.supportedCurrencies
    guard let index = list.index(of: selectedCurrency) else { return }
    selectedCurrency = list[(index + 1) % list.count]
    
    guard let coin = coin else { return }
    view.didChangePreviewCurrency(selectedCurrency, coin: coin)
  }

}


// MARK: - BalanceInteractorOutput

extension BalancePresenter: BalanceInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    view.didReceiveCurrency(wallet.localCurrency)
  }
  
  func didReceiveCoins(_ coins: [Coin]) {
    guard let coin = coins.first else { return }
    self.coin = coin
    view.didReceiveCoin(coin)
  }
  
  func didReceiveTokens(_ tokens: [Token]) {
    view.endRefreshing()
    view.didReceiveTokens(tokens)
  }
  
  func didFailedWalletReceiving(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
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
  
  func syncDidChangeProgress(current: Int64, total: Int64) {
    
  }
  
  func syncDidFinished() {
  }

}
