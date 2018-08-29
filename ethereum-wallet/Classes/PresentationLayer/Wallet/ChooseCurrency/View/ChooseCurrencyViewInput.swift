// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol ChooseCurrencyViewInput: class, Presentable {
  func setupInitialState()
  func selectCurrency(with iso: String)
}
