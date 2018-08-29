// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
