// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


class TransactionsInteractor {
  weak var output: TransactionsInteractorOutput!
  
  var transactionRepository: TransactionRepository!
  var balanceUpdater: BalanceUpdater!
  
  let transactionId = Identifier()
  
  deinit {
    transactionRepository.removeObserver(id: transactionId)
  }
}


// MARK: - TransactionsInteractorInput

extension TransactionsInteractor: TransactionsInteractorInput {
  
  func getTransactions() {
    transactionRepository.addObserver(id: transactionId) { [weak self] transactions in
      self?.output.didReceiveTransactions(transactions.map { TransactionDisplayer(tx: $0) })
    }
  }
  
  func updateTransactions() {
    balanceUpdater.update()
  }
  
}

