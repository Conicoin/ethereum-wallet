// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol SendSettingsModuleInput: class {
  var output: SendSettingsModuleOutput? { get set }
  func present(from viewController: UIViewController, settings: SendSettings, coin: AbstractCoin, output: SendSettingsModuleOutput?)
}
