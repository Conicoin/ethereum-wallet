// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol WelcomeModuleInput: class {
  var output: WelcomeModuleOutput? { get set }
  func present(state: WelcomeState)
}
