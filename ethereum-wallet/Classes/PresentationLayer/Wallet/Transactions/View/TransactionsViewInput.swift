// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TransactionsViewInput: class, Presentable {
  func setupInitialState()
  func stopRefreshing()
  func setTransactions(_ transactions: [TransactionDisplayer])
}
