// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class ApplicationConfigurator: ConfiguratorProtocol {
  
  let app: Application
  let keychain: Keychain
  let accountService: AccountServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(app: Application, keychain: Keychain, accountService: AccountServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.app = app
    self.keychain = keychain
    self.accountService = accountService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func configure() {
    let wallet = walletDataStoreService.find()
    if wallet.count > 0 && keychain.isAuthorized {
      let isSecureMode = Defaults.mode.isSecureMode
      TabBarModule.create(app: app, isSecureMode: isSecureMode).present()
    } else {
      if let account = accountService.currentAccount {
        WelcomeModule.create(app: app).present(state: .restore(account: account))
      } else {
        WelcomeModule.create(app: app).present(state: .new)
      }
    }
  }
  
}
