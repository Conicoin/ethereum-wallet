//
//  CoinViewModel.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct BalanceViewModel {
  let currency: Currency
  let rateSource: RateSource
  
  var amountString: String {
    return FiatCurrencyFactory.amount(amount: currency.value, currency: currency, iso: currency.iso, rate: 1)
  }
  
  func fiatLabelString(for selectedCurrency: String) -> String {
    return rateSource.fiatLabelString(currency: currency, selectedCurrency: selectedCurrency)
  }
  
}
