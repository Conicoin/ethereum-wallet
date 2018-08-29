// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

protocol CoinDisplayable {
  var balance: Currency! { get }
  var rates: [Rate] { get }
  var color: UIColor { get }
  var gasLimit: Decimal { get }
  var contract: String? { get }
  var tokenMeta: TokenMeta? { get }
  var isToken: Bool { get }
  var decimals: Int! { get }
  func amountString(with amount: Decimal) -> String
  func placeholder(with size: CGSize) -> UIImage
}

extension CoinDisplayable {
  
  var isToken: Bool {
    return self is Token
  }
  
  var description: String {
    return Localized.balanceLabel(balance.iso.uppercased(), balance.name)
  }
  
  func fiatLabelString(_ currency: String) -> String {
    guard currency != balance.iso else {
      return description
    }
    return amount(for: currency) ?? description
  }
  
  func rawAmount(for currency: String) -> Double {
    guard let rate = rate(for: currency) else {
      return 0
    }
    return balance.value * rate.value
  }
  
  func fiatString(amount: Currency, iso: String) -> String? {
    guard let rate = rate(for: iso) else {
      return nil
    }
    return FiatCurrencyFactory.amount(currency: amount, iso: iso, rate: rate.value)
  }
  
  fileprivate func rate(for currency: String) -> Rate? {
    return rates.filter({ $0.to == currency }).first
  }
  
  fileprivate func amount(for currency: String) -> String? {
    guard let rate = rate(for: currency) else {
      return nil
    }
    return FiatCurrencyFactory.amount(currency: balance, iso: currency, rate: rate.value)
  }
  
}

extension Coin: CoinDisplayable {
  
  var color: UIColor {
    return .white
  }
  
  var gasLimit: Decimal {
    return Constants.Send.defaultGasLimit
  }
  
  var contract: String? {
    return nil
  }
  
  var tokenMeta: TokenMeta? {
    return nil
  }
  
  var decimals: Int! {
    return 18
  }
  
  func placeholder(with size: CGSize) -> UIImage {
    return R.image.ethereumIcon()!.withRenderingMode(.alwaysTemplate)
  }
  
  func amountString(with amount: Decimal) -> String {
    return Ether(amount).amountString
  }
  
}

extension Token: CoinDisplayable {

  var gasLimit: Decimal {
    return Constants.Send.defaultGasLimitToken
  }
  
  var color: UIColor {
    return Theme.Color.gray
  }
  
  var contract: String? {
    return self.address
  }
  
  var tokenMeta: TokenMeta? {
    return TokenMeta(address: address, name: balance.name, iso: balance.iso, decimals: decimals)
  }
  
  func placeholder(with size: CGSize) -> UIImage {
    let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    return balance.symbol.renderImage(font: font, size: size, color: color)
  }
  
  func amountString(with amount: Decimal) -> String {
    let tokenValue = TokenValue.init(amount, name: balance.name, iso: balance.iso, decimals: 0)
    return tokenValue.amountString
  }
  
}
