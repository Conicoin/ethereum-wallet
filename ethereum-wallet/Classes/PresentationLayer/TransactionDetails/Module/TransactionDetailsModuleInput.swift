//
//  TransactionDetailsTransactionDetailsModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol TransactionDetailsModuleInput: class {
  var output: TransactionDetailsModuleOutput? { get set }
  func present(with displayer: TransactionDisplayer, from viewController: UIViewController)
}
