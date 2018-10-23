// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class FiatCurrencyFactory {
  
  enum FieldKey: String {
    case name
    case symbol
  }
  
  static func create() -> [FiatCurrency] {
    return Constants.Wallet.supportedCurrencies.map { iso in
      return FiatCurrency(iso: iso,
                          name: name(iso),
                          symbol: symbol(iso),
                          icon: icon(iso))
    }
  }
  
  static func create(iso: String) -> FiatCurrency {
    return FiatCurrency(iso: iso,
                        name: name(iso),
                        symbol: symbol(iso),
                        icon: icon(iso))
  }
  
  static func amount(amount: Double, currency: Currency, iso: String, rate: Double) -> String {
    let currency = FiatCurrencyFactory.create(iso: iso)
    let total = amount * rate
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = .current
    currencyFormatter.currencyCode = currency.iso
    currencyFormatter.currencySymbol = currency.symbol
    currencyFormatter.maximumFractionDigits = 5
    currencyFormatter.minimumFractionDigits = 0
    return currencyFormatter.string(from: Decimal(floatLiteral: total) as NSDecimalNumber)!
  }
  
  static func amount(currency: Currency, rate: Double) -> String {
    return FiatCurrencyFactory.amount(amount: currency.value, currency: currency, iso: currency.iso, rate: rate)
  }
  
  static func amount(currency: Currency, iso: String, rate: Double) -> String {
    return FiatCurrencyFactory.amount(amount: currency.value, currency: currency, iso: iso, rate: rate)
  }
  
  static func amount(amount: Double, iso: String) -> String {
    let currency = Ether(amount)
    return FiatCurrencyFactory.amount(amount: amount, currency: currency, iso: iso, rate: 1)
  }
  
  static func amount(amount: Double, currency: Currency) -> String {
    return FiatCurrencyFactory.amount(amount: amount, currency: currency, iso: currency.iso, rate: 1)
  }
  
  static func amount(currency: Currency) -> String {
    return FiatCurrencyFactory.amount(amount: currency.value, currency: currency, iso: currency.iso, rate: 1)
  }
  
  // MARK: Privates
  
  private static func name(_ iso: String) -> String {
    if let name = findField(.name, iso: iso) {
      return name
    }
    
    let locale = Locale.current as NSLocale
    if let name = locale.displayName(forKey: NSLocale.Key.currencyCode, value: iso) {
      return name
    } else {
      return iso
    }
  }
  
  private static func symbol(_ iso: String) -> String {
    if let name = findField(.symbol, iso: iso) {
      return name
    }
    
    let locale = Locale.current as NSLocale
    if let symbol = locale.displayName(forKey: NSLocale.Key.currencySymbol, value: iso) {
      return symbol
    } else {
      return iso
    }
  }
  
  static func icon(_ iso: String) -> UIImage? {
    guard !iso.isEmpty else { return nil }
    return UIImage(named: iso.uppercased())
  }
  
  private static func findField(_ field: FieldKey, iso: String) -> String? {
    let path = Bundle.main.path(forResource: "currencies", ofType: "json")!
    guard
      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: [.alwaysMapped]),
      let dict = try? JSONDecoder().decode([String: [String: String]].self, from: data) else {
        return nil
    }
    
    return (dict[iso.uppercased()])?[field.rawValue]
  }
  
}
