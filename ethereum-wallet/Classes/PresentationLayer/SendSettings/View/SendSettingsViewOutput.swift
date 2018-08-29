// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol SendSettingsViewOutput: class {
  func viewIsReady()
  func gasPriceDidChanged(_ gasPrice: Int)
  func gasLimitDidChanged(_ gasLimit: Int)
  func txDataDidChanged(_ txData: Data)
  func saveDidPressed()
}
