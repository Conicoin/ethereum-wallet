//
//  MnemonicMnemonicViewOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol MnemonicViewOutput: class {
  func viewIsReady()
  func skipPressed()
  func okPressed()
  func clearPressed()
  func wordPressed(_ word: String)
}
