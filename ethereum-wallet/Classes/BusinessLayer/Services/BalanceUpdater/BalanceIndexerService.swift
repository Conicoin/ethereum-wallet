//
//  BalanceIndexer.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol BalanceIndexer {
  func start(id: Identifier, callback: @escaping (BalanceViewModel) -> Void)
  func removeObserver(id: Identifier)
}

class BalanceIndexerService: BalanceIndexer {
  
  let rateSource: RateSource
  let transactionRepository: TransactionRepository
  init(rateSource: RateSource,
       transactionRepository: TransactionRepository) {
    self.rateSource = rateSource
    self.transactionRepository = transactionRepository
  }
  
  func start(id: Identifier, callback: @escaping (BalanceViewModel) -> Void) {
    callback(calculate(transactionRepository.transactions))
    transactionRepository.addObserver(id: id) { transactions in
      // TODO: Check is transactions changed
      callback(self.calculate(transactions))
    }
  }
  
  func removeObserver(id: Identifier) {
    transactionRepository.removeObserver(id: id)
  }
  
  // MARK: Privates
  
  private func calculate(_ transactions: [Transaction]) -> BalanceViewModel {
    var amount: Decimal = 0
    for tx in transactions {
      
      if !tx.isIncoming {
        amount -= (tx.gasUsed * tx.gasPrice)
      }

      guard tx.amount.iso == "ETH" && tx.error == nil else {
        continue
      }
      
      // TODO: Token transfers with amount
      // TODO: Contract creation transfer
      if tx.isIncoming {
        amount += tx.amount.raw
      } else {
        amount -= tx.amount.raw
      }
    }
    amount = max(amount, 0)
    let ether = Ether(weiValue: amount)
    return BalanceViewModel(currency: ether, rateSource: rateSource)
  }
 
}
