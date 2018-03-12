//
//  UIView+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

extension UIView {
  
  var isTransparent: Bool {
    get {
      return alpha == 0
    }
    set {
      alpha = newValue ? 0 : 1
    }
  }

}
