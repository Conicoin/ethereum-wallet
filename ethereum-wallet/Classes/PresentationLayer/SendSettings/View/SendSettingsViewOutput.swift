//
//  SendSettingsSendSettingsViewOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 02/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol SendSettingsViewOutput: class {
  func viewIsReady()
  func gasPriceDidChanged(_ gasPrice: Int)
  func gasLimitDidChanged(_ gasLimit: Int)
  func txDataDidChanged(_ txData: Data)
  func saveDidPressed()
}
