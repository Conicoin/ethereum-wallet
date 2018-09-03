// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

enum TransferType {
  case `default`(Coin)
  case token(Token)
  
  var decimals: Int {
    switch self {
    case .default:
      return 18
    case .token(let token):
      return token.decimals
    }
  }
}
