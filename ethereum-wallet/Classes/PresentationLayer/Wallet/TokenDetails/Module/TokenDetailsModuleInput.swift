// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol TokenDetailsModuleInput: class {
  var output: TokenDetailsModuleOutput? { get set }
  func present(with token: Token, from: UIViewController)
}
