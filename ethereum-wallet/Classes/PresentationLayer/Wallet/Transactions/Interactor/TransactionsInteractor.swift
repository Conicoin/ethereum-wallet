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
    transactionRepository.addObserver(id: transactionId, fire: true) { [weak self] transactions in
      let txs = transactions.filter { !($0.isNormal && $0.input.starts(with: "0xa9059cbb")) }
      let displayers = txs.map { TransactionDisplayer(tx: $0) }
      DispatchQueue.main.async {
        self?.output.didReceiveTransactions(displayers)
      }
    }
  }
  
  func updateTransactions() {
    balanceUpdater.update()
  }
  
}

