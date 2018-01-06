//
//  ImportImportModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import UIKit

protocol ImportModuleInput: class {
  var output: ImportModuleOutput? { get set }
  func present(from viewController: UIViewController)
}
