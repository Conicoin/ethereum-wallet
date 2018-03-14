//
//  Created by Artur Guseynov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class PopupModule {
    
  class func create(_ popupState: PopupState) -> PopupModuleInput {
    let router = PopupRouter()
    let presenter = PopupPresenter()
    let interactor = PopupInteractor()
    let viewController = R.storyboard.popup.popupViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // MARK: Injection
    presenter.popupState = PopupStateFactory(state: popupState).create()
        
    return presenter
  }
    
}
