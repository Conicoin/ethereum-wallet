//
//  UIViewController+Helpers.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 24/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func wrapToNavigationController() -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: self)
    navigationController.navigationBar.prefersLargeTitles = true
    return navigationController
  }

}
