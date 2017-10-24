//
//  BalanceBalanceModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol BalanceModuleInput: class {
  var output: BalanceModuleOutput? { get set }
  var viewController: UIViewController { get }
}
