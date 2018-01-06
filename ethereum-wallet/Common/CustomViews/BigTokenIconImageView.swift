//
//  BigTokenIconView.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

class BigTokenIconView: UIView {
  
  override func layoutSubviews() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 4
    let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 22)
    layer.shadowPath = shadowPath.cgPath
    layer.cornerRadius = 22
    layer.masksToBounds = false
  }
  
}
