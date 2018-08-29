// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class BalanceRouter {

}


// MARK: - BalanceRouterInput

extension BalanceRouter: BalanceRouterInput {

  func presentSend(for coin: Coin, from: UIViewController) {
    SendModule.create(.default(coin)).presentSend(with: coin, from: from)
  }
  
  func presentReceive(for coin: Coin, from: UIViewController) {
    ReceiveModule.create().presentSend(for: coin, from: from)
  }
  
  func presentDetails(for token: Token, from: UIViewController) {
    TokenDetailsModule.create().present(with: token, from: from)
  }
  
}
