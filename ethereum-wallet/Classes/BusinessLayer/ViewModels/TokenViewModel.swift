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
  let rateSource: RateSource
  
  func rawAmount(in selectedCurrency: String) -> Double {
    return rateSource.rawAmount(for: token.balance, in: selectedCurrency)
  }
  
  func amountString() -> String {
    return token.balance.amountString
  }
  
  func description() -> String {
    return Localized.balanceLabel(token.balance.iso.uppercased(), token.balance.name)
  }
  
  func fiatLabelString(for selectedCurrency: String) -> String {
    return rateSource.fiatLabelString(currency: token.balance, selectedCurrency: selectedCurrency)
  }
}

extension TokenViewModel: Equatable {
  
  static func == (lhs: TokenViewModel, rhs: TokenViewModel) -> Bool {
    return lhs.token == rhs.token
  }
}
