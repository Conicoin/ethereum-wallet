// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
