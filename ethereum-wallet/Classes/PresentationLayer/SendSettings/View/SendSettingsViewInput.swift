// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol SendSettingsViewInput: class, Presentable {
  func setupInitialState(settings: SendSettings, coin: CoinDisplayable)
  func setFeeAmount(_ amount: String, fiatAmount: String?)
}
