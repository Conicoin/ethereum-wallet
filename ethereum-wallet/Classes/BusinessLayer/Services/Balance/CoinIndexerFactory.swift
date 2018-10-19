//
//  CoinIndexerFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class CoinIndexerFactory {
  
  let app: Application
  init(app: Application) {
    self.app = app
  }
  
  func create() -> CoinIndexer {
    let rateSource = RateService(rateRepository: app.rateRepository)
    return CoinIndexerService(coinRepository: app.coinRepository,
                              transactionsRepository: app.transactionRepository,
                              rateSource: rateSource)
  }
  
}
