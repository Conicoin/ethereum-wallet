//
//  UITextField+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
