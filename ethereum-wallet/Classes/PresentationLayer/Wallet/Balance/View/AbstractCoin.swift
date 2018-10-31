//
//  AbstractCoin.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct AbstractCoin {
  
  var currency: Currency {
    switch type {
    case .default(let coin):
      return coin.balance
    case .token(let token):
      return token.balance
    }
  }
  
  var isToken: Bool {
    switch type {
    case .default:
      return false
    case .token:
      return true
    }
  }
  
  var decimals: Int {
    return type.decimals
  }
  
  var gasLimit: Decimal {
    return type.gasLimit
  }
  
  let type: CoinType
  let rateSource: RateSource
  init(type: CoinType, rateSource: RateSource) {
    self.type = type
    self.rateSource = rateSource
  }
  
  func fiatString(in iso: String) -> String {
    return rateSource.fiatString(for: currency, in: iso)
  }
  
  func rawAmount(iso: String) -> Decimal {
    return rateSource.rawAmount(for: currency, in: iso)
  }
  
  func fiatLabelString(_ selectedCurrency: String) -> String {
    return rateSource.fiatLabelString(currency: currency, selectedCurrency: selectedCurrency)
  }
  
  func fiatString(amount: Decimal, iso: String) -> String? {
    var currencyWithAmount = currency
    currencyWithAmount.value = amount
    return rateSource.fiatString(for: currencyWithAmount, in: iso)
  }
  
}
