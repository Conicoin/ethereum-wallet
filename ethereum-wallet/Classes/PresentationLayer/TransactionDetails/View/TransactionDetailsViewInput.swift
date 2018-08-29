// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol TransactionDetailsViewInput: class, Presentable {
  func setupInitialState()
  func didReceiveTransaction(_ transaction: TransactionDisplayer)
}
