// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class SendModule {
    
  class func create(_ type: TransferType) -> SendModuleInput {
    let router = SendRouter()
    let presenter = SendPresenter()
    let interactor = SendInteractor()
    let viewController: SendViewController = ScreenManager.instantiate(R.storyboard.send)
    
    interactor.output = presenter
    
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // MARK: - Injection
    
    let core = Ethereum.core
    let keystore = KeystoreService()
    
    interactor.gasService = GasServiceFactory(core: core).create(type)
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.transactionsDataStoreService = TransactionsDataStoreService()
    interactor.transactionService = TransactionService(core: core, keystore: keystore, transferType: type)
    interactor.checkoutService = SendCheckoutServiceFactory().create(type)
    
    viewController.amountFormatter = AmountFormatter(decimals: type.decimals)
        
    return presenter
  }
    
}
