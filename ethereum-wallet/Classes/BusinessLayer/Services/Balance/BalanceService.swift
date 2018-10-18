//
//  BalanceService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol EtherBalancer {
  func start(id: Identifier, callback: @escaping (Currency) -> Void)
  func removeObserver(id: Identifier)
}

class EtherBalanceService: EtherBalancer {
  
  var callback: ((Currency) -> Void)?
  var coin: Coin?
  var transactions: [Transaction] = []
  
  let coinRepository: CoinRepositiry
  let transactionsRepository: TransactionsRepository
  init(coinRepository: CoinRepositiry, transactionsRepository: TransactionsRepository) {
    self.coinRepository = coinRepository
    self.transactionsRepository = transactionsRepository
  }
  
  // MARK: Privates
  
  private func calculate() -> Currency {
    var balance = Ether()
    if let coin = coin {
      balance.raw += coin.balance.raw
    }
    let pending = transactions.filter { $0.amount.iso == "ETH" && $0.isPending == true }
    for tx in pending {
      balance.raw -= tx.amount.raw
    }
    precondition(balance.raw >= 0)
    return balance
  }
  
  func start(id: Identifier, callback: @escaping (Currency) -> Void) {
    coinRepository.addObserver(id: id) { coin in
      self.coin = coin
      self.callback?(self.calculate())
    }
    transactionsRepository.addObserver(id: id) { transactions in
      self.transactions = transactions
      self.callback?(self.calculate())
    }
  }
  
  
  func removeObserver(id: Identifier) {
    coinRepository.removeObserver(id: id)
    transactionsRepository.removeObserver(id: id)
  }

}
