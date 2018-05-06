//
//  SendSettingsSendSettingsModule.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 02/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


class SendSettingsModule {

  class func create() -> SendSettingsModuleInput {
    let router = SendSettingsRouter()
    let presenter = SendSettingsPresenter()
    let interactor = SendSettingsInteractor()
    let viewController = R.storyboard.sendSettings.sendSettingsViewController()!

    interactor.output = presenter

    viewController.output = presenter

    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor

    // MARK: Injection
    interactor.walletDataStoreService = WalletDataStoreService()

    return presenter
  }

}
