// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

enum CoinType {
  case `default`(Coin)
  case token(Token)
  
  var tokenMeta: TokenMeta? {
    switch self {
    case .default:
      return nil
    case .token(let token):
      // TODO: Think about TokenMeta and Token value
      // Amount will be replaced in PendingTxBuilder
      return TokenMeta(value: token.balance, address: token.address)
    }
  }
  
  var decimals: Int {
    switch self {
    case .default:
      return 18
    case .token(let token):
      return token.decimals
    }
  }
  
  var gasLimit: Decimal {
    switch self {
    case .default:
      return Constants.Send.defaultGasLimit
    case .token:
      return Constants.Send.defaultGasLimitToken
    }
  }
}
