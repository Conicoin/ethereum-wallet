// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


protocol SettingsViewOutput: class {
  func viewIsReady()
  func didCurrencyPressed()
  func didChangePasscodePressed()
  func didBackupPressed()
  func didTouchIdValueChanged(_ isOn: Bool)
  func didPushValueChanged(_ isOn: Bool)
  func didLogoutPressed()
  func didRateAppPressed()
}
