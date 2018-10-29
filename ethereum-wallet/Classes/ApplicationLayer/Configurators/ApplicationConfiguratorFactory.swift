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
    let applicationConfigurator = ApplicationConfigurator(app: app,
                                                          accountService: accountService)
    return applicationConfigurator
  }

}
