//
//  ResponsiveButton.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 03/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class ResponsiveButton: UIButton {
  
  struct Const {
    static var duration = 0.05
    static var alpha: CGFloat = 0.9
    static var scale: CGFloat = 0.95
  }
  
  var shouldTransform: Bool = true
  var shouldChangeAlpha: Bool = true
  
  override var isHighlighted: Bool {
    didSet {
      UIView.animate(withDuration: Const.duration) {
        if self.shouldTransform {
          let scale = self.isHighlighted ? Const.scale : 1
          self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        if self.shouldChangeAlpha {
          self.alpha = self.isHighlighted ? Const.alpha : 1
        }
      }
    }
  }
}
