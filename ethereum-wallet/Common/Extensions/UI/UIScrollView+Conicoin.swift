// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

extension UIScrollView {
  
  func setupBorder() {
    let border = BorderView()
    border.attach(to: self)
  }
  
}
