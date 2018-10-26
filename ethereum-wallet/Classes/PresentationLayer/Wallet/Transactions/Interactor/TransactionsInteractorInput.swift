// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol TransactionsInteractorInput: class {
  func getTransactions()
  func updateTransactions()
}
