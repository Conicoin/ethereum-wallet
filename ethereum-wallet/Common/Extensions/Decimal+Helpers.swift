// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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

extension Decimal {
  
  init(_ string: String) {
    if let _ = Decimal(string: string) {
      self.init(string: string)!
      return
    }
    
    self.init(string: "0")!
  }
  
  var string: String {
    return String(describing: self)
  }
  
  var double: Double {
    return NSDecimalNumber(decimal:self).doubleValue
  }
  
  func abbrevation() -> String {
    let numFormatter = NumberFormatter()
    
    typealias Abbrevation = (threshold: Decimal, divisor: Decimal, suffix: String)
    let abbreviations:[Abbrevation] = [(0, 1, ""),
                                       (1000.0, 1000.0, "K"),
                                       (100_000.0, 1_000_000.0, "M"),
                                       (100_000_000.0, 1_000_000_000.0, "B")]
    // you can add more !
    
    let abbreviation: Abbrevation = {
      var prevAbbreviation = abbreviations[0]
      for tmpAbbreviation in abbreviations {
        if self < tmpAbbreviation.threshold {
          break
        }
        prevAbbreviation = tmpAbbreviation
      }
      return prevAbbreviation
    } ()
    
    let value = self / abbreviation.divisor
    numFormatter.positiveSuffix = abbreviation.suffix
    numFormatter.negativeSuffix = abbreviation.suffix
    numFormatter.allowsFloats = true
    numFormatter.minimumIntegerDigits = 1
    numFormatter.minimumFractionDigits = 0
    numFormatter.maximumFractionDigits = 1
    
    return numFormatter.string(for: value) ?? self.string
  }
  
}
