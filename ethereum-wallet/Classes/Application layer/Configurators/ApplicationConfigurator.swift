// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class ApplicationConfigurator: ConfiguratorProtocol {
  
  let keychain: Keychain
  let accountService: AccountServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(keychain: Keychain, accountService: AccountServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.keychain = keychain
    self.accountService = accountService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func configure() {
    let wallet = walletDataStoreService.find()
    if wallet.count > 0 && keychain.isAuthorized {
      let isSecureMode = Defaults.mode.isSecureMode
      TabBarModule.create(isSecureMode: isSecureMode).present()
    } else {
      if let account = accountService.currentAccount {
        WelcomeModule.create().present(state: .restore(account: account))
      } else {
        WelcomeModule.create().present(state: .new)
      }
    }
  }
  
}
