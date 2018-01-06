//
//  Created by Artur Guseynov on 25/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class ImportModule {
    
  class func create() -> ImportModuleInput {
    let router = ImportRouter()
    let presenter = ImportPresenter()
    let interactor = ImportInteractor()
    let viewController = R.storyboard.start.importViewController()!

    interactor.output = presenter
    interactor.keystore = KeystoreService()

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
