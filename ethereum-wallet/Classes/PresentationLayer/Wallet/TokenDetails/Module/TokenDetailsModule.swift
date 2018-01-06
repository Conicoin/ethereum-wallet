//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TokenDetailsModule {
    
  class func create() -> TokenDetailsModuleInput {
    let router = TokenDetailsRouter()
    let presenter = TokenDetailsPresenter()
    let interactor = TokenDetailsInteractor()
    let viewController = R.storyboard.wallet.tokenDetailsViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
