//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TabBarModule {
    
  class func create() -> TabBarModuleInput {
    let router = TabBarRouter()
    let presenter = TabBarPresenter()
    let interactor = TabBarInteractor()
    let viewController = R.storyboard.wallet.tabBarViewController()!

    interactor.output = presenter
    interactor.ethereumService = Ethereum.core
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.transactionsDataStoreServise = TransactionsDataStoreService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    return presenter
  }
    
}
