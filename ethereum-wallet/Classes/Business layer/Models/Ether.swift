// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit

struct Ether {
  
  let raw: Decimal
  let value: Double

  init(_ value: Decimal) {
    self.raw = value * 1e18
    self.value = value.double
  }
  
  init(weiValue: Decimal) {
    self.raw = weiValue
    self.value = weiValue.double / 1e18
  }
  
  init(_ double: Double) {
    self.raw = Decimal(double) * 1e18
    self.value = double
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
    return "Ethereum"
  }
  
  var iso: String {
    return "ETH"
  }
  
  var symbol: String {
    return "Ξ"
  }

}
