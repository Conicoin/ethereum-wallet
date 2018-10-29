//
//  BalanceIndexer.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol BalanceIndexer {
  var viewModel: BalanceViewModel! { get }
  func start(id: Identifier, callback: @escaping (BalanceViewModel) -> Void)
  func removeObserver(id: Identifier)
}

class BalanceIndexerService: BalanceIndexer {
  
  let id = Identifier()
  var viewModel: BalanceViewModel!
  
  let channel: Channel<BalanceViewModel>
  let rateSource: RateSource
  let transactionRepository: TransactionRepository
  let rateRepository: RateRepositoryService
  
  init(channel: Channel<BalanceViewModel>,
       rateSource: RateSource,
       transactionRepository: TransactionRepository,
       rateRepository: RateRepositoryService) {
    self.channel = channel
    self.rateSource = rateSource
    self.transactionRepository = transactionRepository
    self.rateRepository = rateRepository
    
    transactionRepository.addObserver(id: id, fire: true) { _ in
      let viewModel = self.calculate()
      self.viewModel = viewModel
      channel.send(viewModel)
    }
  }
  
  // MARK: BalanceIndexer
  
  func start(id: Identifier, callback: @escaping (BalanceViewModel) -> Void) {
    callback(viewModel)
    
    let observer = Observer<BalanceViewModel>(id: id, callback: callback)
    channel.addObserver(observer)
    
    rateRepository.addObserver(id: id, fire: false) { _ in
      // Just ask to update ui
      callback(self.viewModel)
    }
  }
  
  func removeObserver(id: Identifier) {
    transactionRepository.removeObserver(id: id)
  }
  
  // MARK: Privates
  
  private func calculate() -> BalanceViewModel {
    var amount: Decimal = 0
    let transactions = transactionRepository.transactions
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
