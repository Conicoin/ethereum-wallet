// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


protocol SettingsViewInput: class, Presentable {
  func setupInitialState()
  func shareFileAtUrl(_ url: URL)
  func setIsTouchIdEnabled(_ isTouchIdEnabled: Bool)
  func setCurrency(_ currency: FiatCurrency)
  func setPushSwitch(_ iOn: Bool)
}
