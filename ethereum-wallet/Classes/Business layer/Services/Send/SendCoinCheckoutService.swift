//
//  SendCheckoutService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class SendCoinCheckoutService: SendCheckoutServiceProtocol {
  
  func checkout(for coin: CoinDisplayable, amount: Decimal, iso: String, fee: Decimal) throws -> Checkout {
    let rate = coin.rates.first(where: {$0.to == iso})
    
    let feeAmount = Ether(weiValue: fee)
    let feeAmountString = feeAmount.amountString
    
    let fiatAmount = Ether(amount)
    let fiatAmountString = FiatCurrencyFactory.amount(currency: fiatAmount, iso: iso, rate: rate?.value ?? 0)
    
    let ethAmount = Ether(amount + fee.fromWei())
    let ethAmountString = ethAmount.amountString
    
    return (amount: fiatAmount.amountString, total: ethAmountString, fiatAmount: fiatAmountString, fee: feeAmountString)
  }
  
}
