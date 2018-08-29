// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol PinModuleInput: class {
  var output: PinModuleOutput? { get set }
  func present(from viewController: UIViewController, postProcess: PinPostProcess?, nextScene: PinNextScene?)
  func presentModal(from viewController: UIViewController, postProcess: PinPostProcess?, nextScene: PinNextScene?)
}
