// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TokenDetailsViewInput: class, Presentable {
  func setupInitialState()
  func didReceiveToken(_ token: Token)
  func didReceiveFiatBalance(_ balance: String)
  func didReceiveTransactions(_ transactions: [TransactionDisplayer])
}
