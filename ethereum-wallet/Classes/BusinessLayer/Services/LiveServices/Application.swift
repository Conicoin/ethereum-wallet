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
                            walletRepository: walletRepository)
  }()
  
  
  // MARK - Repositories
  
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
  
  
  // MARK: - Indexers
  
  lazy var balanceIndexer: BalanceIndexer = {
    let rateSource = RateService(rateRepository: rateRepository)
    return BalanceIndexerService(channel: channelRepository.balanceChannel,
                                 rateSource: rateSource,
                                 transactionRepository: transactionRepository,
                                 rateRepository: rateRepository)
  }()
  
  lazy var tokenIndexer: TokenIndexer = {
    let rateSource = RateService(rateRepository: rateRepository)
    return TokenIndexerService(channel: channelRepository.tokenChannel,
                               rateSource: rateSource,
                               transactionRepository: transactionRepository,
                               rateRepository: rateRepository)
  }()
  
  
  // MARK: - Global updaters
  
  lazy var balanceUpdater: BalanceUpdater = {
    return BalanceUpdaterService(walletRepository: walletRepository,
                                 transactionDataStoreService: TransactionsDataStoreService(),
                                 transactionNetworkService: TransactionsNetworkService())
  }()
  
  lazy var ratesUpdater: RatesUpdater = {
    return RatesUpdaterService(tokenIndexer: tokenIndexer,
                               rateDataStoreService: RatesDataStoreService(),
                               rateNetworkService: RatesNetworkService())
  }()
  
  
  // MARK: - Channels
  
  lazy var channelRepository: ChannelRepository = {
    return ChannelRepository()
  }()
  
}

