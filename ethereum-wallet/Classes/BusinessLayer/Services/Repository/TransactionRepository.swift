//
//  TransactionRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol TransactionsRepository {
  var transactions: [Transaction] { get }
  func addObserver(id: Identifier, callback: @escaping ([Transaction]) -> Void)
  func removeObserver(id: Identifier)
}

class TransactionRepositoryService: TransactionsRepository {
  
  var transactions: [Transaction] = []
  
  let channel: Channel<[Transaction]>
  let transactionDataStoreService: TransactionsDataStoreServiceProtocol
  init(channel: Channel<[Transaction]>, transactionDataStoreService: TransactionsDataStoreServiceProtocol) {
    self.channel = channel
    self.transactionDataStoreService = transactionDataStoreService
    
    transactionDataStoreService.observe { transactions in
      self.transactions = transactions
      self.channel.send(transactions)
    }
  }
  
  func addObserver(id: Identifier, callback: @escaping ([Transaction]) -> Void) {
    callback(transactions)
    let observer = Observer<[Transaction]>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  func removeObserver(id: Identifier) {
    channel.removeObserver(withId: id)
  }
  
}
