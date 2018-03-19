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
  
  func didSelectToken(_ token: Token) {
    router.presentDetails(for: token, from: view.viewController)
  }

}


// MARK: - BalanceInteractorOutput

extension BalancePresenter: BalanceInteractorOutput {
  
  func didReceiveWallet(_ wallet: Wallet) {
    view.didReceiveWallet(wallet)
  }
  
  func didReceiveCoins(_ coins: [Coin]) {
    guard let coin = coins.first else { return }
    view.didReceiveCoin(coin)
  }
  
  func didReceiveTokens(_ tokens: [Token]) {
    view.didReceiveTokens(tokens)
  }
  
  func didFailedWalletReceiving(with error: Error) {
    error.showAllertIfNeeded(from: view.viewController)
  }
  
  func didFailedTokensReceiving(with error: Error) {
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
