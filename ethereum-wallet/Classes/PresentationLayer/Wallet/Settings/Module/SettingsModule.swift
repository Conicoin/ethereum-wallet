// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


class SettingsModule {
  
  class func create(app: Application) -> SettingsModuleInput {
    let router = SettingsRouter()
    let presenter = SettingsPresenter()
    let interactor = SettingsInteractor()
    let viewController = R.storyboard.settings.settingsViewController()!
    
    interactor.output = presenter
    
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    router.app = app
    
    // Injection
    let keychain = Keychain()
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.walletRepository = app.walletRepository
    interactor.keystore = KeystoreService()
    interactor.keychain = keychain
    interactor.pushService = PushService()
    interactor.accountService = AccountService(keychain: keychain)
    interactor.biometryService = BiometryService()
    interactor.pushConfigurator = app.pushConfigurator
    
    return presenter
  }
  
}
