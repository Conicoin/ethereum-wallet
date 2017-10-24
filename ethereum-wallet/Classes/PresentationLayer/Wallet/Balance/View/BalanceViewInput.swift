//
//  BalanceBalanceViewInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol BalanceViewInput: class, Presentable {
  func setupInitialState()
  func syncDidChangeProgress(current: Float, total: Float)
  func syncDidFinished()
  func didReceiveWallet(_ wallet: Wallet)
}
