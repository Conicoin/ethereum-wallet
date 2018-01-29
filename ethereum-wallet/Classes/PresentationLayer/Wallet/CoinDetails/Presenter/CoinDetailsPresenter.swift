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


class CoinDetailsPresenter {
  
  weak var view: CoinDetailsViewInput!
  weak var output: CoinDetailsModuleOutput?
  var interactor: CoinDetailsInteractorInput!
  var router: CoinDetailsRouterInput!
  
  var coin: Coin!
}


// MARK: - CoinDetailsViewOutput

extension CoinDetailsPresenter: CoinDetailsViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    view.didReceiveCoin(coin)
  }
  
  func didSendPressed() {
    router.presentSend(for: coin, from: view.viewController)
  }
  
  func didReceivePressed() {
    router.presentReceive(for: coin, from: view.viewController)
  }
  
}


// MARK: - CoinDetailsInteractorOutput

extension CoinDetailsPresenter: CoinDetailsInteractorOutput {
  
}


// MARK: - CoinDetailsModuleInput

extension CoinDetailsPresenter: CoinDetailsModuleInput {
  
  func present(with coin: Coin, from: UIViewController) {
    // TODO: coin balance observing
    self.coin = coin
    view.present(fromViewController: from)
  }
  
}
