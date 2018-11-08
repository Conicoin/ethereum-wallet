// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

struct TokenViewModel {
  let token: Token
  let currency: Currency
  let rateSource: RateSource
  
  func rawAmount(in selectedCurrency: String) -> Decimal {
    return rateSource.rawAmount(for: currency, in: selectedCurrency)
  }
  
  func amountString() -> String {
    return currency.amountString
  }
  
  func description() -> String {
    return Localized.balanceLabel(currency.iso.uppercased(), currency.name)
  }
  
  func fiatLabelString(for selectedCurrency: String) -> String {
    return rateSource.fiatLabelString(currency: currency, selectedCurrency: selectedCurrency)
  }
}

extension TokenViewModel: Equatable {
  
  static func == (lhs: TokenViewModel, rhs: TokenViewModel) -> Bool {
    return lhs.token == rhs.token
  }
}
