//
//  TabBarTabBarViewInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol TabBarViewInput: class, Presentable {
  var viewControllers: [UIViewController]? { get set }
  func setupInitialState()
}
