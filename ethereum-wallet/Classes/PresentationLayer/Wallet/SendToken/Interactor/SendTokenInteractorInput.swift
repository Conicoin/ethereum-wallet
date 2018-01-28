//
//  SendTokenSendTokenInteractorInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol SendTokenInteractorInput: class {
  func getWallet()
  func getGasLimit()
  func getGasPrice()
  func sendTransaction(for token: Token, amount: Decimal, to: String, gasLimit: Decimal)
  func getCheckout(iso: String, fee: Decimal)
}
