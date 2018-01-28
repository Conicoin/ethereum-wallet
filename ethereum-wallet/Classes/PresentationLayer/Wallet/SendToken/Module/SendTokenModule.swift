//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class SendTokenModule {
    
  class func create() -> SendTokenModuleInput {
    let router = SendTokenRouter()
    let presenter = SendTokenPresenter()
    let interactor = SendTokenInteractor()
    let viewController = R.storyboard.sendToken.sendTokenViewController()!
  
    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    let core = Ethereum.core
    let keystore = KeystoreService()
    
    let gasService = GasService(core: core)
    interactor.gasService = gasService
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.coinDataStoreService = CoinDataStoreService()
    interactor.transactionsDataStoreService = TransactionsDataStoreService()
    interactor.transactionService = TransactionService(core: core, keystore: keystore, transferType: .token)
    
    return presenter
  }
    
}
