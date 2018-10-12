// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class PartnersModule {

  class func create() -> PartnersModuleInput {
    let router = PartnersRouter()
    let presenter = PartnersPresenter()
    let interactor = PartnersInteractor()
    let viewController = R.storyboard.partners.partnersViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor

    // MARK: Injection

    return presenter
  }

}
