// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


protocol ReceiveModuleInput: class {
  var output: ReceiveModuleOutput? { get set }
  func presentSend(from: UIViewController)
}
