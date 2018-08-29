// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit


protocol TransactionDetailsRouterInput: class {
  func presentEtherscan(with txHash: String, from: UIViewController)
}
