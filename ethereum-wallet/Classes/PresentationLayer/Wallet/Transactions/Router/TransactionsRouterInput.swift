// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TransactionsRouterInput: class {
  func presentDetails(with txIndex: TransactionDisplayer, from: UIViewController)
}
