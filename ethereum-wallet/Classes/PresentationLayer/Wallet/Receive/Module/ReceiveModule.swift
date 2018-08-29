// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ReceiveModule {
    
  class func create() -> ReceiveModuleInput {
    let router = ReceiveRouter()
    let presenter = ReceivePresenter()
    let interactor = ReceiveInteractor()
    let viewController = R.storyboard.receive.receiveViewController()!

    interactor.output = presenter
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.qrService = QRService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
