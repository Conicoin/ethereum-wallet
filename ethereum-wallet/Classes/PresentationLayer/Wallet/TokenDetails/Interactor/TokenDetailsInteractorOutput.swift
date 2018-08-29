// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol TokenDetailsInteractorOutput: class {
  func didReceiveTransactions(_ transactions: [TransactionDisplayer])
}
