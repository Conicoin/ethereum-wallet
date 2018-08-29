// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

protocol ShadowHidable: class {
  var shadowImage: UIImage! { get set }
}

extension ShadowHidable where Self: UIViewController {
  
  func showNavBarSeparator(_ show: Bool) {
    if show {
      navigationController?.navigationBar.shadowImage = shadowImage
    } else {
      shadowImage = navigationController?.navigationBar.shadowImage
      navigationController?.navigationBar.shadowImage = UIImage()
    }
  }
  
}
