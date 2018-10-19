// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TokenDetailsRouterInput: class {
  func presentSend(for viewModel: TokenViewModel, from: UIViewController)
  func presentDetails(with transaction: TransactionDisplayer, from: UIViewController)
}
