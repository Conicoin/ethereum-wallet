// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TransactionsModuleInput: class {
  var output: TransactionsModuleOutput? { get set }
  var viewController: UIViewController { get }
}
