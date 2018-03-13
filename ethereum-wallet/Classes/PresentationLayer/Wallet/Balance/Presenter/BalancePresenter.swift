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
  
  var coins = [Coin]()
  var tokens = [Token]()
  var localCurrency = Constants.Wallet.defaultCurrency
  var chain: Chain {
    return Defaults.chain
  }
  
}


// MARK: - BalanceViewOutput

extension BalancePresenter: BalanceViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    output?.balanceViewIsReady()
    interactor.getWalletFromDataBase()
    interactor.getCoinsFromDataBase()
    interactor.getTokensFromDataBase()
  }
  
  func viewIsAppear() {
    interactor.getEthereumFromNetwork()
    interactor.getTokensFromNetwork()
  }
  
  func didRefresh() {
    interactor.getEthereumFromNetwork()
    interactor.getTokensFromNetwork()
  }
  
  func didSelectCoin(at index: Int) {
    router.presentDetails(for: coins[index], from: view.viewController)
  }
  
  func didSelectToken(at index: Int) {
    router.presentDetails(for: tokens[index], from: view.viewController)
  }

}


// MARK: - BalanceInteractorOutput

extension BalancePresenter: BalanceInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    self.localCurrency = wallet.localCurrency
    view.didReceiveWallet()
  }
  
  func didReceiveCoins(_ coins: [Coin]) {
    self.coins = coins
    view.didReceiveCoins()
  }
  
  func didReceiveTokens(_ tokens: [Token]) {
    self.tokens = tokens
    view.didReceiveTokens()
  }
  
  func didFailedWalletReceiving(with error: Error) {
    view.stopRefreshing()
    error.showAllertIfNeeded(from: view.viewController)
  }

}


// MARK: - BalanceModuleInput

extension BalancePresenter: BalanceModuleInput {
  
  var viewController: UIViewController {
    return view.viewController
  }
  
  func syncDidChangeProgress(current: Int64, total: Int64) {
    view.syncDidChangeProgress(current: Float(current), total: Float(total))
  }
  
  func syncDidFinished() {
    view.syncDidFinished()
  }

}
