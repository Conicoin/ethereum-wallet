//
//  CoinIndexerService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol CoinIndexer {
  func start(id: Identifier, callback: @escaping (CoinViewModel) -> Void)
  func removeObserver(id: Identifier)
}

class CoinIndexerService: CoinIndexer {
  
  var coin: Coin?
  var transactions: [Transaction] = []
  
  let coinRepository: CoinRepositiry
  let transactionsRepository: TransactionRepository
  let rateSource: RateSource
  init(coinRepository: CoinRepositiry,
       transactionsRepository: TransactionRepository,
       rateSource: RateSource) {
    self.rateSource = rateSource
    self.coinRepository = coinRepository
    self.transactionsRepository = transactionsRepository
  }
  
  // MARK: Privates
  
  private func calculate() -> CoinViewModel {
    var amount = Ether()
    if let coin = coin {
      amount.raw += coin.balance.raw
    }
    let pending = transactions.filter { $0.amount.iso == "ETH" && $0.isPending == true }
    for tx in pending {
      amount.raw -= tx.amount.raw
    }
    precondition(amount.raw >= 0)
    
    let balance = CoinViewModel(coin: coin, currency: amount, rateSource: rateSource)
    return balance
  }
  
  func start(id: Identifier, callback: @escaping (CoinViewModel) -> Void) {
    coinRepository.addObserver(id: id) { coin in
      self.coin = coin
      callback(self.calculate())
    }
    transactionsRepository.addObserver(id: id) { transactions in
      self.transactions = transactions
      callback(self.calculate())
    }
  }
  
  
  func removeObserver(id: Identifier) {
    coinRepository.removeObserver(id: id)
    transactionsRepository.removeObserver(id: id)
  }

}
