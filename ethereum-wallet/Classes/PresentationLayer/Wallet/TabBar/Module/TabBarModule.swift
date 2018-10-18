// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class TabBarModule {
    
  class func create(app: Application, isSecureMode: Bool) -> TabBarModuleInput {
    let router = TabBarRouter()
    let presenter = TabBarPresenter()
    let interactor = TabBarInteractor()
    let viewController = R.storyboard.tabBar.tabBarViewController()!
    
    let core = Ethereum.core
    if isSecureMode {
      let keystore = KeystoreService()
      let syncCoordinator = LesSyncCoordinator(context: core.context, keystore: keystore)
      core.syncCoordinator = syncCoordinator
      interactor.ethereumService = core
    } else {
      let syncCoordinator = StandardSyncCoordinator()
      core.syncCoordinator = syncCoordinator
      interactor.ethereumService = core
    }

    interactor.output = presenter
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.transactionsDataStoreServise = TransactionsDataStoreService()
    interactor.coinsDataStoreService = CoinDataStoreService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app
    
    return presenter
  }
    
}
