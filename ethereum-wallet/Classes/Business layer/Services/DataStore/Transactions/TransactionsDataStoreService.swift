//
//  TransactionsDataStoreService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation

class TransactionsDataStoreService: RealmStorable<Transaction>, TransactionsDataStoreServiceProtocol {
  
  typealias PlainType = Transaction
  
  func getTransactions() -> [Transaction] {
    return find()
  }
  
  func saveTransactions(_ transactions: [Transaction]) {
    save(transactions)
  }

}
