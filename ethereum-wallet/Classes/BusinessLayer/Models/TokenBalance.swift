// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import ObjectMapper

struct TokenBalance: ImmutableMappable {
  let balance: Decimal
  
  init(map: Map) throws {
    let balanceString: String = try map.value("result")
    self.balance = Decimal(balanceString)
  }
}
