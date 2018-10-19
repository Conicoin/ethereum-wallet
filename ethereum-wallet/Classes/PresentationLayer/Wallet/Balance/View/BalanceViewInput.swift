// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol BalanceViewInput: class, Presentable {
  func setupInitialState()
  func endRefreshing()
  func setTotalTokenAmount(_ currency: String)
  func setPreviewTitle(_ currency: String, coin: CoinViewModel)
  func setCoin(_ viewModel: CoinViewModel)
  func setTokens(_ viewModels: [TokenViewModel])
}
