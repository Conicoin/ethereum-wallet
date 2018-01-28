//
//  UIViewController+NavBarShadow.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
