//
//  TransactionInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

struct TransactionInput {
  
  let raw: Data
  let address: String
  let amount: Decimal
  
  init?(input: Data) {
    guard input.starts(with: [0x0, 0xa9, 0x05, 0x9c, 0xbb]) else {
      return nil
    }
    let addressData = input[input.count-32-20..<input.count-32]
    let amountData = input[input.count-32..<input.count]
    self.address = "0x" + addressData.toHexString()
    self.amount = Decimal(hexString: amountData.toHexString())
    self.raw = input
  }
  
}
