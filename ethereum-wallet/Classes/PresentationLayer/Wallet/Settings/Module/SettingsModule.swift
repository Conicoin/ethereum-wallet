// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


class SettingsModule {
  
  class func create() -> SettingsModuleInput {
    let router = SettingsRouter()
    let presenter = SettingsPresenter()
    let interactor = SettingsInteractor()
    let viewController = R.storyboard.settings.settingsViewController()!
    
    interactor.output = presenter
    interactor.walletDataStoreService = WalletDataStoreService()
    interactor.keystore = KeystoreService()
    
    viewController.output = presenter
    
    presenter.view = viewController
    presenter.router = router
    presenter.interactor = interactor
    
    // Injection
    let keychain = Keychain()
    interactor.keychain = keychain
    interactor.pushService = PushService()
    interactor.accountService = AccountService(keychain: keychain)
    interactor.biometryService = BiometryService()
    interactor.pushConfigurator = PushConfigurator(pushNetworkService: PushNetworkService(),
                                                   walletDataStoreService: WalletDataStoreService())
    
    return presenter
  }
  
}
