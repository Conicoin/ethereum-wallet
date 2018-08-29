// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol SendViewInput: class, Presentable {
  func setupInitialState()
  func setCurrency(_ currency: String)
  func inputDataIsValid(_ isValid: Bool)
  func setCoin(_ coin: CoinDisplayable)
  func setAddressFromQR(_ address: String)
  func setLocalAmount(_ localAmount: String?)
  func setCheckout(amount: String, total: String, fee: String)
  func loadingFilure()
}
