// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class Application {
  
  lazy var locker: LockerProtocol = {
    return LockerFactory(app: self).create()
  }()
  
  lazy var backupper: BackupServiceProtocol = {
    let keychain = Keychain()
    let accountService = AccountService(keychain: keychain)
    return BackupService(app: self, keychain: keychain, accountService: accountService)
  }()
  
  lazy var screenLocker: ScreenLockerProtocol = {
    return ScreenLocker()
  }()
  
  lazy var pushConfigurator: PushConfiguratorProtocol = {
    return PushConfigurator(pushNetworkService: PushNetworkService(),
                            walletDataStoreService: WalletDataStoreService())
  }()
  
  lazy var coinDataStoreService: CoinDataStoreServiceProtocol = {
    return CoinDataStoreService()
  }()
  
  lazy var transactionDataStoreService: TransactionsDataStoreServiceProtocol = {
    return TransactionsDataStoreService()
  }()
  
  lazy var channelRepository: ChannelRepository = {
    return ChannelRepository()
  }()
  
  lazy var coinRepository = {
    return CoinRepositiryService(channel: channelRepository.coinChannel,
                                 coinDataStoreService: coinDataStoreService)
  }()
  
  lazy var transactionRepository = {
    return TransactionRepositoryService(channel: channelRepository.transactionsChannel,
                                        transactionDataStoreService: transactionDataStoreService)
  }()
  
  lazy var etherBalancer: EtherBalancer = {
    return EtherBalanceService(coinRepository: coinRepository,
                               transactionsRepository: transactionRepository)
  }()
}

