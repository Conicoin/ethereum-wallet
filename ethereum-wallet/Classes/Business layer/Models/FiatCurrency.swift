// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class FiatCurrency {
  
  let iso: String
  let name: String
  let symbol: String
  let icon: UIImage?
  
  init(iso: String, name: String, symbol: String, icon: UIImage?) {
    self.iso = iso
    self.name = name
    self.symbol = symbol
    self.icon = icon
  }

}
