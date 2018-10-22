// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TransactionsViewOutput: class {
  func viewIsReady()
  func viewIsAppear()
  func didRefresh()
  func didTransactionPressed(_ txIndex: TransactionDisplayer)
}
