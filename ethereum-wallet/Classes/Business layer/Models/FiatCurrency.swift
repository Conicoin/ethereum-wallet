//
//  FiatCurrency.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
