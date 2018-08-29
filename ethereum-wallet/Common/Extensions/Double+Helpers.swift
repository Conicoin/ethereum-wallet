// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation

extension Double {
  
  func amount(for iso: String) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = .current
    currencyFormatter.currencyCode = iso
    return currencyFormatter.string(from: Decimal(floatLiteral: self) as NSDecimalNumber)!
  }
  
}
