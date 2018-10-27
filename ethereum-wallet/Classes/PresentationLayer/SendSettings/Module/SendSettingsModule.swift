// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


class SendSettingsModule {

  class func create(app: Application) -> SendSettingsModuleInput {
    let router = SendSettingsRouter()
    let presenter = SendSettingsPresenter()
    let interactor = SendSettingsInteractor()
    let viewController = R.storyboard.sendSettings.sendSettingsViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app

    // MARK: Injection
    interactor.walletRepository = app.walletRepository

    return presenter
  }

}
