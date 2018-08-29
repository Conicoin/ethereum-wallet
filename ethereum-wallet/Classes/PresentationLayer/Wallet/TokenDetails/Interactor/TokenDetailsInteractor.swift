// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


class TokenDetailsInteractor {
  weak var output: TokenDetailsInteractorOutput!
  
  var transactionsDataStoreService: TransactionsDataStoreServiceProtocol!
}


// MARK: - TokenDetailsInteractorInput

extension TokenDetailsInteractor: TokenDetailsInteractorInput {
  
  func getTransactions(for token: Token) {
    transactionsDataStoreService.observe(token: token) { [unowned self] transactions in
      let displayers = transactions.map { TransactionDisplayer(tx: $0) }
      self.output.didReceiveTransactions(displayers)
    }
  }
  
}
