// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol TransactionDetailsModuleInput: class {
  var output: TransactionDetailsModuleOutput? { get set }
  func present(with displayer: TransactionDisplayer, from viewController: UIViewController)
}
