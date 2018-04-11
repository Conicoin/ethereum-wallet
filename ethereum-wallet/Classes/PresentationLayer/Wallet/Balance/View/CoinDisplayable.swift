// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit

protocol CoinDisplayable {
  var balance: Currency! { get }
  var rates: [Rate] { get }
  var color: UIColor { get }
  var iconUrl: URL? { get }
  func placeholder(with size: CGSize) -> UIImage
}

extension Coin: CoinDisplayable {
  
  var iconUrl: URL? {
    return nil
  }
  
  var color: UIColor {
    return Theme.Color.ethereum
  }
  
  func placeholder(with size: CGSize) -> UIImage {
    return R.image.ethereumIcon()!.withRenderingMode(.alwaysTemplate)
  }
  
}

extension Token: CoinDisplayable {
  
  var color: UIColor {
    return Theme.Color.token
  }
  
  func placeholder(with size: CGSize) -> UIImage {
    let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    return balance.symbol.renderImage(font: font, size: size, color: color)
  }
  
  func amount(for currency: String) -> String? {
    guard let rate = rate(for: currency) else {
      return nil
    }
    return FiatCurrencyFactory.amount(currency: balance, rate: rate.value)
  }
  
  func rawAmount(for currency: String) -> Double {
    guard let rate = rate(for: currency) else {
      return 0
    }
    return balance.value * rate.value
  }
  
  func rate(for currency: String) -> Rate? {
    return rates.filter({ $0.to == currency }).first
  }
  
}
