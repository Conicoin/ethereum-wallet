//
//  TransactionDetailsTransactionDetailsRouterInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 01/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit


protocol TransactionDetailsRouterInput: class {
  func presentEtherscan(with txHash: String, from: UIViewController)
}
