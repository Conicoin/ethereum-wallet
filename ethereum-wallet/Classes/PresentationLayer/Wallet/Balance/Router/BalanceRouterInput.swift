// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol BalanceRouterInput: class {
  func presentSend(for coin: Coin, from: UIViewController)
  func presentReceive(from: UIViewController)
  func presentDetails(for viewModel: TokenViewModel, from: UIViewController)
}
