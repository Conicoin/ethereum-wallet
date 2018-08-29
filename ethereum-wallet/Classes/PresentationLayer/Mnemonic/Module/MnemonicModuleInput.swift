// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol MnemonicModuleInput: class {
  var output: MnemonicModuleOutput? { get set }
  func present(from viewController: UIViewController, state: MnemonicState, completion: ((UIViewController) -> Void)?)
  func presentModal(from viewController: UIViewController, state: MnemonicState, completion: ((UIViewController) -> Void)?)
}
