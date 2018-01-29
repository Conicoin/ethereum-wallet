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


class BalanceModule {
    
  class func create() -> BalanceModuleInput {
    let router = BalanceRouter()
    let presenter = BalancePresenter()
    let interactor = BalanceInteractor()
    let viewController = R.storyboard.balance.balanceViewController()!

    interactor.output = presenter
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.walletNetworkService = WalletNetworkService()
    interactor.coinDataStoreService = CoinDataStoreService()
    interactor.ratesNetworkService = RatesNetworkService()
    interactor.ratesDataStoreService = RatesDataStoreService()
    interactor.tokensNetworkService = TokensNetworkService()
    interactor.tokensDataStoreService = TokenDataStoreService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
