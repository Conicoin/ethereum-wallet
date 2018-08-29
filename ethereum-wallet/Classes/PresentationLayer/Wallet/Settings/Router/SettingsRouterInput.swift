// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import UIKit


protocol SettingsRouterInput: class {
  func presentChooseCurrency(from: UIViewController, selectedIso: String, output: ChooseCurrencyModuleOutput)
  func presentPinOnExit(from: UIViewController, postProcess: PinPostProcess?)
  func presentPinOnChangePin(from: UIViewController, postProcess: PinPostProcess?)
  func presentPinOnBackup(from: UIViewController, postProcess: PinPostProcess?)
  func presentMnemonicBackup(from: UIViewController)
}
