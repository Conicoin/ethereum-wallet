// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class PinModule {
    
  class func create(app: Application, state: PinState) -> PinModuleInput {
    let router = PinRouter()
    let presenter = PinPresenter()
    let interactor = PinInteractor()
    let viewController = R.storyboard.pin.pinViewController()!
    
    interactor.output = presenter
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app
    
    // MARK: Injection

    let pinService = PinServiceFactory.create(with: state, delegate: presenter)
    interactor.pinService = pinService

    return presenter
  }
    
}
