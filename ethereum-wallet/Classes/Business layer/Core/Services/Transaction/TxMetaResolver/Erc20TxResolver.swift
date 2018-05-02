//
//  Erc20TxResolver.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class Erc20TxResolver: TxMetaResolver {

  var nextResolver: TxMetaResolver?
  
  func resolve(_ input: Data) -> TxType {

    guard input.starts(with: [0xa9, 0x05, 0x9c, 0xbb]) else {
      return nextResolver(for: input)
    }
    let addressData = input[input.count-32-20..<input.count-32]
    let amountData = input[input.count-32..<input.count]
    let address = "0x" + addressData.hex()
    let value = Decimal(hexString: amountData.hex()).string
    return .erc20(to: address, value: value)
  }
  
  @discardableResult
  func chain(_ next: TxMetaResolver) -> TxMetaResolver {
    self.nextResolver = next
    return next
  }
  
}
