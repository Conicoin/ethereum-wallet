//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class CoinDetailsModule {
    
  class func create() -> CoinDetailsModuleInput {
    let router = CoinDetailsRouter()
    let presenter = CoinDetailsPresenter()
    let interactor = CoinDetailsInteractor()
    let viewController = R.storyboard.wallet.coinDetailsViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
