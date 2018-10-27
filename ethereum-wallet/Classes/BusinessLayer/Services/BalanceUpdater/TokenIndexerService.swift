//
//  TokenBalancerService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol TokenIndexer {
  var viewModels: [TokenViewModel] { get } 
  func start(id: Identifier, callback: @escaping ([TokenViewModel]) -> Void)
  func removeObserver(id: Identifier)
}

class TokenIndexerService: TokenIndexer {
  
  let id = Identifier()
  var viewModels: [TokenViewModel] = []
  
  let channel: Channel<[TokenViewModel]>
  let rateSource: RateSource
  let transactionRepository: TransactionRepository
  let rateRepository: RateRepository
  
  init(channel: Channel<[TokenViewModel]>,
       rateSource: RateSource,
       transactionRepository: TransactionRepository,
       rateRepository: RateRepository) {
    self.channel = channel
    self.rateSource = rateSource
    self.transactionRepository = transactionRepository
    self.rateRepository = rateRepository
    
    transactionRepository.addObserver(id: id) { _ in
      let viewModels = self.calculate()
      self.viewModels = viewModels
      channel.send(viewModels)
    }
    
    rateRepository.addObserver(id: id) { _ in
      // Just ask to update ui
      channel.send(self.viewModels)
    }
  }
  
  // MARK: TokenIndexer
  
  func start(id: Identifier, callback: @escaping ([TokenViewModel]) -> Void) {
    callback(viewModels)
    let observer = Observer<[TokenViewModel]>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  
  func removeObserver(id: Identifier) {
    transactionRepository.removeObserver(id: id)
  }
  
  // MARK: Privates
  
  private func calculate() -> [TokenViewModel] {
    var balances = [String: TokenValue]()
    let transactions = transactionRepository.transactions
    for tx in transactions {
      guard let tokenMeta = tx.tokenMeta else { continue }
      
      if balances[tokenMeta.address] == nil {
        var tokenValue = tokenMeta.value
        tokenValue.raw = 0
        balances[tokenMeta.address] = tokenValue
      }
      if tx.isIncoming {
        balances[tokenMeta.address]!.raw = balances[tokenMeta.address]!.raw + tokenMeta.value.raw
      } else {
        balances[tokenMeta.address]!.raw = balances[tokenMeta.address]!.raw - tokenMeta.value.raw
      }
    }
    let notZero = balances
      .filter { $0.value.raw > 0 }
    let viewModels = notZero.keys.map { address -> TokenViewModel in
      let value = balances[address]!
      let token = Token(balance: value, address: address, decimals: value.decimals)
      let viewModel = TokenViewModel(token: token, currency: value, rateSource: rateSource)
      return viewModel
    }
    return viewModels
  }
  
}
