//
//  Created by Artur Guseynov on 19/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class WelcomeModule {
    
  class func create() -> WelcomeModuleInput {
    let router = WelcomeRouter()
    let presenter = WelcomePresenter()
    let interactor = WelcomeInteractor()
    let viewController = R.storyboard.start.welcomeViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
        
    return presenter
  }
    
}
