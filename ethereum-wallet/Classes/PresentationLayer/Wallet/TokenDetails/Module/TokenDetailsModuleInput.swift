//
//  TokenDetailsTokenDetailsModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol TokenDetailsModuleInput: class {
  var output: TokenDetailsModuleOutput? { get set }
  func present(with token: Token, from: UIViewController)
}
