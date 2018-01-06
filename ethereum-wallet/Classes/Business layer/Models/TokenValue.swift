//
//  TokenValue.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

struct TokenValue: Currency {
  
  let raw: Decimal
  let value: Double
  let name: String
  let iso: String
  
  init(_ value: Decimal, name: String, iso: String) {
    self.raw = value
    self.value = value.double / 1e18
    self.name = name
    self.iso = iso
  }
  
  init(_ string: String, name: String, iso: String) {
    let number = Decimal(string)
    self.init(number, name: name, iso: iso)
  }
  
  var symbol: String {
    return iso
  }
  
}
