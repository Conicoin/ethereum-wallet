//
//  PopupPopupModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol PopupModuleInput: class {
  var output: PopupModuleOutput? { get set }
  func present(from viewController: UIViewController, completion: @escaping (UIViewController) -> Void)
}
