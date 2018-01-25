//
//  TransactionInfo.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct TransactionInfo {
  let amount: Decimal
  let address: String
  let contractAddress: String?
  let gasLimit: Decimal
}
