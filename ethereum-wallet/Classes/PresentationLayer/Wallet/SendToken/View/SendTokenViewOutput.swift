//
//  SendTokenSendTokenViewOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol SendTokenViewOutput: class {
  func viewIsReady()
  func didSendPressed()
  func didScanPressed()
  func didChangeAmount(_ amount: String)
  func didChangeAddress(_ address: String)
  func didChangeGasLimit(_ gasLimit: String)
}
