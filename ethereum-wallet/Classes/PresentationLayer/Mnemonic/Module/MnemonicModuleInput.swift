//
//  MnemonicMnemonicModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol MnemonicModuleInput: class {
  var output: MnemonicModuleOutput? { get set }
  func present(from viewController: UIViewController, completion: ((UIViewController) -> Void)?)
}
