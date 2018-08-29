// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol PopupModuleInput: class {
  var output: PopupModuleOutput? { get set }
  func present(from viewController: UIViewController, completion: @escaping (UIViewController) -> Void)
}
