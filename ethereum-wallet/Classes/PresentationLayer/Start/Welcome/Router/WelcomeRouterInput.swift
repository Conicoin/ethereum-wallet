// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol WelcomeRouterInput: class {
  func presentPinNew(from viewController: UIViewController, postProcessor: PinPostProcess?)
  func presentPinRestore(from viewController: UIViewController, postProcess: PinPostProcess?)
  func presentImportJson(from viewController: UIViewController)
  func presentImportPrivate(from viewController: UIViewController)
  func presentImportMnemonic(from viewController: UIViewController)
}
