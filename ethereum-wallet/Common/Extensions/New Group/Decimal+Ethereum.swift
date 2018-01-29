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

// MARK: - Converters 

extension Decimal {

  func fromWei() -> Decimal {
    return self / 1e18
  }
  
  func toWei() -> Decimal {
    return self * 1e18
  }
  
  func localToEther(rate: Double) -> Decimal {
    return self / Decimal(rate)
  }
  
  func etherToLocal(rate: Double) -> Decimal {
    return self * Decimal(rate)
  }
  
  func weiToGwei() -> Decimal {
    return self / 1000000000
  }
  
  func toHex() -> String {
    return representationOf(base: 16)
  }
  
  func amount(for iso: String) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = .current
    currencyFormatter.currencyCode = iso
    return currencyFormatter.string(from: self as NSDecimalNumber)!
  }
  
  init(hexString: String) {
    self.init(hexString, base: 16)
  }
  
}

// MARK: - Privates

extension Decimal {
  
  private func rounded(mode: NSDecimalNumber.RoundingMode) -> Decimal {
    var this = self
    var result = Decimal()
    NSDecimalRound(&result, &this, 0, mode)
    
    return result
  }
  
  private func integerDivisionBy(_ operand: Decimal) -> Decimal{
    let result = (self / operand)
    return result.rounded(mode: result < 0 ? .up : .down)
  }
  
  private func truncatingRemainder(dividingBy operand: Decimal) -> Decimal {
    return self - self.integerDivisionBy(operand) * operand
  }
  
  private init(_ string: String, base: Int) {
    var decimal: Decimal = 0
    
    let digits = string.characters
      .map { String($0) }
      .map { Int($0, radix: base)! }
    
    for digit in digits {
      decimal *= Decimal(base)
      decimal += Decimal(digit)
    }
    
    self.init(string: decimal.description)!
  }
  
  private func representationOf(base: Decimal) -> String {
    var buffer: [Int] = []
    var n = self
    
    while n > 0 {
      buffer.append((n.truncatingRemainder(dividingBy: base) as NSDecimalNumber).intValue)
      n = n.integerDivisionBy(base)
    }
    
    return buffer
      .reversed()
      .map { String($0, radix: (base as NSDecimalNumber).intValue ) }
      .joined()
  }
}
