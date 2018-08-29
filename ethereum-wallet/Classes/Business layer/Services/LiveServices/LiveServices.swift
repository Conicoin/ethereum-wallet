// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class LiveServices {
  
  lazy var locker: LockerProtocol = {
    return LockerFactory().create()
  }()
  
  lazy var backupper: BackupServiceProtocol = {
    let keychain = Keychain()
    let accountService = AccountService(keychain: keychain)
    return BackupService(keychain: keychain, accountService: accountService)
  }()
  
  lazy var screenLocker: ScreenLockerProtocol = {
    return ScreenLocker()
  }()
  
  lazy var pushConfigurator: PushConfiguratorProtocol = {
    return PushConfigurator(pushNetworkService: PushNetworkService(),
                            walletDataStoreService: WalletDataStoreService())
  }()
}

