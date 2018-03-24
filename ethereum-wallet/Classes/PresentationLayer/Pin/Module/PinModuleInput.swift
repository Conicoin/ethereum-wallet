//
//  PinPinModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol PinModuleInput: class {
  var output: PinModuleOutput? { get set }
  func present(from viewController: UIViewController, postProcess: PinPostProcess?, nextScene: PinNextScene?)
}
