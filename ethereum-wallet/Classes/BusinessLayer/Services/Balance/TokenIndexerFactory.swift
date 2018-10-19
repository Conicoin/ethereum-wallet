//
//  TokenIndexerFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class TokenIndexerFactory {
  
  let app: Application
  init(app: Application) {
    self.app = app
  }
  
  func create() -> TokenIndexer {
    let rateSource = RateService(rateRepository: app.rateRepository)
    return TokenIndexerService(rateSource: rateSource,
                               tokenRepository: app.tokenRepository)
  }
  
}
