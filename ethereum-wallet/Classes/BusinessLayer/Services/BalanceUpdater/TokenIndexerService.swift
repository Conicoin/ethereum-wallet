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
  
  let transactionRepository: TransactionRepository
  let rateSource: RateSource
  init(rateSource: RateSource, transactionRepository: TransactionRepository) {
    self.rateSource = rateSource
    self.transactionRepository = transactionRepository
  }
  
  // MARK: Privates
  
  private func calculate(_ transactions: [Transaction]) -> [TokenViewModel] {
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
  
  func start(id: Identifier, callback: @escaping ([TokenViewModel]) -> Void) {
    transactionRepository.addObserver(id: id) { transactions in
      callback(self.calculate(transactions))
    }
  }
  
  
  func removeObserver(id: Identifier) {
    transactionRepository.removeObserver(id: id)
  }
  
}
