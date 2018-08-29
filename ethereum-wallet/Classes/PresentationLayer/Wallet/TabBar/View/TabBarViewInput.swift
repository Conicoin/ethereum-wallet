// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TabBarViewInput: class, Presentable {
  var viewControllers: [UIViewController]? { get set }
  func setupInitialState()
  func setTitles()
}
