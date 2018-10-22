//
//  BalanceUpdaterFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class BalanceUpdaterFactory {
  
  let app: Application
  init(app: Application) {
    self.app = app
  }
  
  func create() -> BalanceUpdater {
    let updater = BalanceUpdaterService(walletRepository: app.walletRepository,
                                               transactionDataStoreService: TransactionsDataStoreService(),
                                               transactionNetworkService: TransactionsNetworkService())
    return updater
  }
}
