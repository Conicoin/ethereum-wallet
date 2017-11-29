// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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


class SendModule {
    
  class func create(forPreview: Bool) -> SendModuleInput {
    let router = SendRouter()
    let presenter = SendPresenter()
    let interactor = SendInteractor()
    
    if forPreview {
      let previewController = R.storyboard.wallet.sendPreviewViewController()!
      previewController.output = presenter
      presenter.view = previewController
    } else {
      let viewController = R.storyboard.wallet.sendViewController()!
      viewController.output = presenter
      presenter.view = viewController
    }
    
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.coinDataStoreService = CoinDataStoreService()
    interactor.ethereumService = Ethereum.core
    interactor.output = presenter
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
