// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
    
    interactor.postProcess = PopupPostProcessFactory(pushService: PushService(),
                                                     biometryService: BiometryService()).create(popupState)
        
    return presenter
  }
    
}
