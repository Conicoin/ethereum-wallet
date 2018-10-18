// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class BalanceRouter {
  var app: Application!
}


// MARK: - BalanceRouterInput

extension BalanceRouter: BalanceRouterInput {

  func presentSend(for coin: Coin, from: UIViewController) {
    SendModule.create(app: app, type: .default(coin)).presentSend(with: coin, from: from)
  }
  
  func presentReceive(for coin: Coin, from: UIViewController) {
    ReceiveModule.create(app: app).presentSend(for: coin, from: from)
  }
  
  func presentDetails(for token: Token, from: UIViewController) {
    TokenDetailsModule.create(app: app).present(with: token, from: from)
  }
  
}
