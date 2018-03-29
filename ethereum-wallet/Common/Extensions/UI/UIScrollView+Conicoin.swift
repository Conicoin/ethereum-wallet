//
//  UIScrollView+Conicoin.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 27/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

extension UIScrollView {
  
  func setupBorder() {
    let border = BorderView()
    border.attach(to: self)
  }
  
}
