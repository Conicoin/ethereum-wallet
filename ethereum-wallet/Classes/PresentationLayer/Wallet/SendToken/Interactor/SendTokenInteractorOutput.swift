//
//  SendTokenSendTokenInteractorOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol SendTokenInteractorOutput: class {
  func didReceiveWallet(_ wallet: Wallet)
  func didReceiveGasLimit(_ gasLimit: Decimal)
  func didReceiveGasPrice(_ gasPrice: Decimal)
  func didSendTransaction()
  func didReceiveCheckout(ethFee: String, fiatFee: String)
  func didFailed(with error: Error)
  func didFailedSending(with error: Error)
}
