// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol SendInteractorOutput: class {
  func didReceiveWallet(_ wallet: Wallet)
  func didReceiveGasLimit(_ gasLimit: Decimal)
  func didReceiveGasPrice(_ gasPrice: Decimal)
  func didReceiveCheckout(amount: String, total: String, fiatAmount: String, fee: String)
  func didFailed(with error: Error)
  func didFailedSending(with error: Error)
}
