// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol TransactionsInteractorOutput: class {
  func didReceiveTransactions(_ transactions: [TransactionDisplayer])
  func didFailedTransactionsReceiving(with error: Error)
}
