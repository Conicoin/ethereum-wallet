//
//  BalanceHandler.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Geth

struct BalanceHandler {
  
  let didUpdateBalance: (Int64) -> Void
  let didReceiveTransactions: ([GethTransaction]) -> Void
  
}
