// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class Application {
  
  // MARK: - App delegate services
  
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
  
  
  // MARK - Repositories
  
  lazy var coinRepository = {
    return CoinRepositiryService(channel: channelRepository.coinChannel,
                                 coinDataStoreService: CoinDataStoreService())
  }()
  
  lazy var transactionRepository = {
    return TransactionRepositoryService(channel: channelRepository.transactionsChannel,
                                        transactionDataStoreService: TransactionsDataStoreService())
  }()
  
  lazy var rateRepository = {
    return RateRepositoryService(channel: channelRepository.rateChannel,
                                 rateDataStoreService: RatesDataStoreService())
  }()
  
  lazy var walletRepository = {
    return WalletRepositoryService(channel: channelRepository.walletChannel,
                                   walletDataStoreService: WalletDataStoreService())
  }()
  
  lazy var tokenRepository = {
    return TokenRepositoryService(channel: channelRepository.tokenChannel,
                                  tokenDataStoreService: TokenDataStoreService())
  }()
  
  
  // MARK: - Channels
  
  lazy var channelRepository: ChannelRepository = {
    return ChannelRepository()
  }()

}

