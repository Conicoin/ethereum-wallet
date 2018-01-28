//
//  SendTokenSendTokenViewInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol SendTokenViewInput: class, Presentable {
  func setupInitialState()
  func inputDataIsValid(_ isValid: Bool)
  func didReceiveToken(_ token: Token)
  func didReceiveGasLimit(_ gasLimit: Decimal)
  func didReceiveGasPrice(_ gasPrice: Decimal)
  func didDetectQRCode(_ code: String)
  func didReceiveCheckout(ethFee: String, fiatFee: String)
  func showLoading()
  func loadingSuccess()
  func loadingFilure()
}
