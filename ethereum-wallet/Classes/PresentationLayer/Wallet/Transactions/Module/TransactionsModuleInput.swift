//
//  TransactionsTransactionsModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol TransactionsModuleInput: class {
  var output: TransactionsModuleOutput? { get set }
  var viewController: UIViewController { get }
}
