// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit

protocol Currency {
  var raw: Decimal { get set }
  var value: Double { get set }
  var name: String { get }
  var iso: String { get }
  var symbol: String { get }
}

// MARK: - Common helpers

extension Currency {
  var fullName: String {
    return "\(name) (\(iso))"
  }
  
  var fullNameWithSymbol: String {
    return "\(symbol)\t\(fullName)"
  }
  
  var amountString: String {
    return FiatCurrencyFactory.amount(currency: self)
  }
    
}
