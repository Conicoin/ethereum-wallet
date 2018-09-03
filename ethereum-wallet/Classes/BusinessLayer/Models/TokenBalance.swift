//
//  TokenBalance.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/09/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import ObjectMapper

struct TokenBalance: ImmutableMappable {
  let balance: Decimal
  
  init(map: Map) throws {
    let balanceString: String = try map.value("result")
    self.balance = Decimal(balanceString)
  }
}
