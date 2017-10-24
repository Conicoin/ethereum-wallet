//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TransactionsModule {
    
  class func create() -> TransactionsModuleInput {
    let router = TransactionsRouter()
    let presenter = TransactionsPresenter()
    let interactor = TransactionsInteractor()
    let viewController = R.storyboard.wallet.transactionsViewController()!

    interactor.output = presenter
    interactor.transactionsDataStoreService = TransactionsDataStoreService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
