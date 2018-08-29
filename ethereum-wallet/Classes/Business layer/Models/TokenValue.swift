// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

struct TokenValue: Currency {
  
  let raw: Decimal
  let value: Double
  let name: String
  let iso: String
  let decimals: Int
  
  init(wei value: Decimal, name: String, iso: String, decimals: Int) {
    self.raw = value
    self.value = value.double / pow(10, Double(decimals))
    self.name = name
    self.iso = iso
    self.decimals = decimals
  }
  
  init(_ value: Decimal, name: String, iso: String, decimals: Int) {
    self.raw = value * Decimal(pow(10, Double(decimals)))
    self.value = value.double
    self.name = name
    self.iso = iso
    self.decimals = decimals
  }
  
  var symbol: String {
    return iso
  }
  
}
