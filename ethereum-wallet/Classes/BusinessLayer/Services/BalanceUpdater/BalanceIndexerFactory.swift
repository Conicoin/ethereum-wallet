//
//  BalanceIndexerFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class BalanceIndexerFactory {
  
  let app: Application
  init(app: Application) {
    self.app = app
  }
  
  func create() -> BalanceIndexer {
    let rateSource = RateService(rateRepository: app.rateRepository)
    let indexer = BalanceIndexerService(rateSource: rateSource, transactionRepository: app.transactionRepository)
    return indexer
  }
  
}
