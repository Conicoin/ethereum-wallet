// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class BalanceRouter {
  var app: Application!
}


// MARK: - BalanceRouterInput

extension BalanceRouter: BalanceRouterInput {

  func presentSend(for coin: Coin, from: UIViewController) {
    let type = CoinType.default(coin)
    SendModule.create(app: app, type: type).presentSend(from: from)
  }
  
  func presentReceive(for coin: Coin, from: UIViewController) {
    ReceiveModule.create(app: app, type: .default(coin)).presentSend(from: from)
  }
  
  func presentDetails(for viewModel: TokenViewModel, from: UIViewController) {
    TokenDetailsModule.create(app: app).present(with: viewModel, from: from)
  }
  
}
