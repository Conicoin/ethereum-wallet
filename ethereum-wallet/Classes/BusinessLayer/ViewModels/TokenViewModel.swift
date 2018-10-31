//
//  TokenViewModel.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
