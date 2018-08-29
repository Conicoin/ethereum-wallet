// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class TransactionDetailsShadowView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    layer.cornerRadius = 24
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 5)
    layer.shadowOpacity = 0.15
    layer.shadowRadius = 30
    layer.masksToBounds =  false
  }
  
}
