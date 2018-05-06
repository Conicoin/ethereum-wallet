//
//  SendSettingsSendSettingsViewInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 02/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol SendSettingsViewInput: class, Presentable {
  func setupInitialState(settings: SendSettings, coin: CoinDisplayable)
  func setFeeAmount(_ amount: String, fiatAmount: String?)
}
