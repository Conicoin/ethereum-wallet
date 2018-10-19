//
//  TokenBalancerService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol TokenIndexer {
  func start(id: Identifier, callback: @escaping ([TokenViewModel]) -> Void)
  func removeObserver(id: Identifier)
}

class TokenIndexerService: TokenIndexer {
  
  var tokens: [Token] = []
  var wallet: Wallet!
  
  let tokenRepository: TokenRepository
  let rateSource: RateSource
  init(rateSource: RateSource, tokenRepository: TokenRepository) {
    self.rateSource = rateSource
    self.tokenRepository = tokenRepository
  }
  
  // MARK: Privates
  
  private func calculate() -> [TokenViewModel] {
    let balances = tokens.map { TokenViewModel(token: $0, rateSource: rateSource) }
    return balances
  }
  
  func start(id: Identifier, callback: @escaping ([TokenViewModel]) -> Void) {
    tokenRepository.addObserver(id: id) { tokens in
      self.tokens = tokens
      callback(self.calculate())
    }
  }
  
  
  func removeObserver(id: Identifier) {
    tokenRepository.removeObserver(id: id)
  }
  
}
