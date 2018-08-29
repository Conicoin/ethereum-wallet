// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol PinViewOutput: class {
  func viewIsReady()
  func viewWillAppear()
  func didAddSign(_ sign: String)
  func didDeleteSign()
  func didTouchIdPressed()
  func didPrivacyPressed()
}
