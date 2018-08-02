//
//  ApplicationConfiguratorFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class ApplicationConfiguratorFactory {
  
  func create() -> ConfiguratorProtocol {
    let keychain = Keychain()
    let accountService = AccountService(keychain: keychain)
    let walletDataStoreService = WalletDataStoreService()
    let applicationConfigurator = ApplicationConfigurator(accountService: accountService, walletDataStoreService: walletDataStoreService)
    return applicationConfigurator
  }

}
