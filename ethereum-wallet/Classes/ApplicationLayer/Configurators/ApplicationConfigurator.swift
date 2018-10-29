// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class ApplicationConfigurator: ConfiguratorProtocol {
  
  let app: Application
  let accountService: AccountServiceProtocol
  
  init(app: Application, accountService: AccountServiceProtocol) {
    self.app = app
    self.accountService = accountService
  }
  
  func configure() {
    if accountService.isAuthorized {
      if !Defaults.walletCreated, let account = accountService.currentAccount {
        WelcomeModule.create(app: app).present(state: .restore(account: account))
        return
      }
      let isSecureMode = Defaults.mode.isSecureMode
      TabBarModule.create(app: app, isSecureMode: isSecureMode).present()
    } else {
      WelcomeModule.create(app: app).present(state: .new)
    }
  }
  
}
