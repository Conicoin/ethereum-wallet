// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol MnemonicViewOutput: class {
  func viewIsReady()
  func skipPressed()
  func okPressed()
  func clearPressed()
  func wordPressed(_ word: String)
}
