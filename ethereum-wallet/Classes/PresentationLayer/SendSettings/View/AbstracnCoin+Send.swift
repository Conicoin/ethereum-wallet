//
//  AbstracnCoin+Send.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


typealias Checkout = (amount: String, total: String, fiatAmount: String, fee: String)

extension AbstractCoin {
  
  func amountString(with amount: Decimal) -> String {
    switch type {
    case .default:
      return Ether(amount).amountString
    case .token:
      let tokenValue = TokenValue(amount, name: currency.name, iso: currency.iso, decimals: 0)
      return tokenValue.amountString
    }
  }
  
  func checkout(amount: Decimal, iso: String, fee: Decimal) -> Checkout {
    let feeAmount = Ether(weiValue: fee)
    let feeAmountString = feeAmount.amountString
    
    let fiatAmount = Ether(amount)
    let fiatAmountString = rateSource.fiatString(for: fiatAmount, in: iso)
    
    switch type {
    case .default:
      let ethAmount = Ether(amount + fee.fromWei())
      let ethAmountString = ethAmount.amountString
      return (amount: fiatAmount.amountString, total: ethAmountString, fiatAmount: fiatAmountString, fee: feeAmountString)
    
    case .token(let token):
      let ethAmountString = FiatCurrencyFactory.amount(amount: amount.double, currency: token.balance)
      return (amount: ethAmountString, total: ethAmountString, fiatAmount: fiatAmountString, fee: feeAmountString)
    }
  }
  
}
