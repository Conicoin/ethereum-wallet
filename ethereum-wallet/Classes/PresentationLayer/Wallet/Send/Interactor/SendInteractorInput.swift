// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol SendInteractorInput: class {
  func getWallet()
  func getGasLimit(from: String, to: String, amount: Decimal, settings: SendSettings) 
  func getGasPrice()
  func sendTransaction(coin: CoinDisplayable, amount: Decimal, to: String, settings: SendSettings, pin: String, pinResult: PinResult?)
  func getCheckout(for coin: CoinDisplayable, amount: Decimal, iso: String, fee: Decimal)
}
