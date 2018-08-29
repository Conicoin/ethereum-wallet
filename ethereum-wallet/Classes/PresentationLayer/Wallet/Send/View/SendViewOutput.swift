// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol SendViewOutput: class {
  func viewIsReady()
  func didSendPressed()
  func didScanPressed()
  func didCurrencyPressed()
  func didChangeAmount(_ amount: String)
  func didChangeAddress(_ address: String)
  func didAdvancedPressed()
}
