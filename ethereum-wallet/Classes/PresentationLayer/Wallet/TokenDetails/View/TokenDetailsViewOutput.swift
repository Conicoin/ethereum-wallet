// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TokenDetailsViewOutput: class {
  func viewIsReady()
  func didSendPressed()
  func didBalanceViewPressed()
  func didTransactionPressed(_ transaction: TransactionDisplayer)
}
