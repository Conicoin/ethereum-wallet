// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol BalanceRouterInput: class {
  func presentSend(for coin: Coin, from: UIViewController)
  func presentReceive(for coin: Coin, from: UIViewController)
  func presentDetails(for token: Token, from: UIViewController)
}
