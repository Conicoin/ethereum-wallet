// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

protocol SyncCoordinatorDelegate: class {
  func syncDidChangeProgress(current: Int64, max: Int64)
  func syncDidFinished()
  func syncDidUpdateBalance(_ balanceHex: String, timestamp: Int64)
  func syncDidUpdateGasLimit(_ gasLimit: Int64)
  func syncDidReceiveTransactions(_ transactions: [GethTransaction], timestamp: Int64)
}
