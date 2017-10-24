//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class PasswordModule {
    
  class func create() -> PasswordModuleInput {
    let router = PasswordRouter()
    let presenter = PasswordPresenter()
    let interactor = PasswordInteractor()
    
    let viewController = R.storyboard.start.passwordViewController()!

    interactor.output = presenter
    interactor.ethereumService = Ethereum.core
    interactor.walletDataStoreService = WalletDataStoreService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    return presenter
  }
    
}
