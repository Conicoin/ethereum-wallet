// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit

struct Ether {
  
  var raw: Decimal
  var value: Double {
    return raw.double / 1e18
  }
  
  init() {
    self.raw = 0
  }

  init(_ value: Decimal) {
    self.raw = value * 1e18
  }
  
  init(weiValue: Decimal) {
    self.raw = weiValue
  }
  
  init(_ double: Double) {
    self.raw = Decimal(double) * 1e18
  }
  
  init(_ string: String) {
    let number = Decimal(string)
    self.init(number)
  }
  
  init(weiString: String) {
    let number = Decimal(weiString)
    self.init(weiValue: number)
  }

}

extension Ether: Currency {
  
  var name: String {
    return Localized.commonEthereum()
  }
  
  var iso: String {
    return "ETH"
  }
  
  var symbol: String {
    return "Ξ"
  }

}
