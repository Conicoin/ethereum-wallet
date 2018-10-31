// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

struct TokenValue: Currency {
  
  var raw: Decimal
  let name: String
  let iso: String
  let decimals: Int
  
  var value: Decimal {
    get {
      return raw / pow(10, decimals)
    }
    set {
      raw = newValue * pow(10, decimals)
    }
  }
  
  init(wei value: Decimal, name: String, iso: String, decimals: Int) {
    self.raw = value
    self.name = name
    self.iso = iso
    self.decimals = decimals
  }
  
  init(_ value: Decimal, name: String, iso: String, decimals: Int) {
    self.raw = value * Decimal(pow(10, Double(decimals)))
    self.name = name
    self.iso = iso
    self.decimals = decimals
  }
  
  var symbol: String {
    return iso
  }
  
}
