// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit
import UIKit

protocol ImportModuleInput: class {
  var output: ImportModuleOutput? { get set }
  func present(from viewController: UIViewController)
}
