// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
  
  var float: Float {
    return NSDecimalNumber(decimal:self).floatValue
  }
  
  var int64: Int64 {
    return NSDecimalNumber(decimal:self).int64Value
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
