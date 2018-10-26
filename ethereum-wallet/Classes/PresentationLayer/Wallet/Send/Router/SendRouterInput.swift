// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol SendRouterInput: class {
  func presentScan(from: UIViewController, output: ScanModuleOutput)
  func presentChooseCurrency(from: UIViewController, selectedIso: String, output: ChooseCurrencyModuleOutput)
  func presentPin(from: UIViewController, amount: String, address: String, postProcess: PinPostProcess?)
  func presentSendSettings(from: UIViewController, settings: SendSettings, coin: AbstractCoin, output: SendSettingsModuleOutput?)
}
