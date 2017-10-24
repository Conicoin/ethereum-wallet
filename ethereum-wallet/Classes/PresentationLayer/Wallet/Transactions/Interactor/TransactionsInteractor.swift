//
//  TransactionsTransactionsInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation


class TransactionsInteractor {
  weak var output: TransactionsInteractorOutput!
  
  var transactionsDataStoreService: TransactionsDataStoreServiceProtocol!
}


// MARK: - TransactionsInteractorInput

extension TransactionsInteractor: TransactionsInteractorInput {

  func getTransactions() {
    let transactions = transactionsDataStoreService.getTransactions()
    output.didReceiveTransactions(transactions)
    transactionsDataStoreService.observe { [unowned self]transactions in
      self.output.didReceiveTransactions(transactions)
    }
  }

}
