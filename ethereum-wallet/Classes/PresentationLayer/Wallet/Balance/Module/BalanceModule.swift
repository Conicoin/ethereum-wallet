//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class BalanceModule {
    
  class func create() -> BalanceModuleInput {
    let router = BalanceRouter()
    let presenter = BalancePresenter()
    let interactor = BalanceInteractor()
    let viewController = R.storyboard.wallet.balanceViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
