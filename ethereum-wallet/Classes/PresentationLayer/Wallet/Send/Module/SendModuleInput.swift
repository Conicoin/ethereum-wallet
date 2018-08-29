// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol SendModuleInput: class {
  var output: SendModuleOutput? { get set }
  func presentSend(with coin: CoinDisplayable, from viewController: UIViewController)
}
