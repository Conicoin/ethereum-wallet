// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol TransactionRepository {
  var transactions: [Transaction] { get }
  func addObserver(id: Identifier, fire: Bool, callback: @escaping ([Transaction]) -> Void)
  func removeObserver(id: Identifier)
}

class TransactionRepositoryService: TransactionRepository {
  
  var transactions: [Transaction] = []
  
  let channel: Channel<[Transaction]>
  let transactionDataStoreService: TransactionsDataStoreServiceProtocol
  init(channel: Channel<[Transaction]>, transactionDataStoreService: TransactionsDataStoreServiceProtocol) {
    self.channel = channel
    
    // To not release notification block
    self.transactionDataStoreService = transactionDataStoreService
    
    self.transactions = transactionDataStoreService.find()
    transactionDataStoreService.observe { transactions in
      self.transactions = transactions
      self.channel.send(transactions)
    }
  }
  
  func addObserver(id: Identifier, fire: Bool, callback: @escaping ([Transaction]) -> Void) {
    if fire {
      callback(transactions)
    }
    let observer = Observer<[Transaction]>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  func removeObserver(id: Identifier) {
    channel.removeObserver(withId: id)
  }
  
}
