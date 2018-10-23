// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift
import ObjectMapper

struct Token {
  
  let balance: TokenValue
  let address: String
  let decimals: Int
  
  init(balance: TokenValue, address: String, decimals: Int) {
    self.balance = balance
    self.address = address
    self.decimals = decimals
  }
}

// MARK: - Equatable

extension Token: Equatable {
  
  static func == (lhs: Token, rhs: Token) -> Bool {
    return lhs.address == rhs.address
    && lhs.balance.amountString == rhs.balance.amountString
  }
  
}
