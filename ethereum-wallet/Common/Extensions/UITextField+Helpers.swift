// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

extension UITextField {
  
  func setLeftPadding(_ amount: CGFloat){
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    leftView = paddingView
    leftViewMode = .always
  }
  
  func setRightPadding(_ amount: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    rightView = paddingView
    rightViewMode = .always
  }
  
}
