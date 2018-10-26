// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class ApplicationConfiguratorFactory {
  
  let app: Application
  
  init(app: Application) {
    self.app = app
  }
  
  func create() -> ConfiguratorProtocol {
    let keychain = Keychain()
    let accountService = AccountService(keychain: keychain)
    let walletDataStoreService = WalletDataStoreService()
    let applicationConfigurator = ApplicationConfigurator(app: app,
                                                          keychain: keychain,
                                                          accountService: accountService,
                                                          walletDataStoreService: walletDataStoreService)
    return applicationConfigurator
  }

}
