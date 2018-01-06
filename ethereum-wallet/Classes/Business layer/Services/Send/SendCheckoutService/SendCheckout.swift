//
//  SendCheckout.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 06/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct SendCheckout {
  let localAmount: String
  let totalAmount: String
  let localFeeAmount: String
  let feeAmount: String
  
  init(localAmount: Decimal, totalAmount: Currency, localFeeAmount: Decimal, feeAmount: Currency, iso: String) {
    self.totalAmount = totalAmount.amount
    self.localAmount = localAmount.amount(for: iso)
    self.feeAmount = feeAmount.amount
    self.localFeeAmount = localFeeAmount.amount(for: iso)
  }
}
