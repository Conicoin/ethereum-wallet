//
//  CoinDetailsCoinDetailsModuleInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol CoinDetailsModuleInput: class {
  var output: CoinDetailsModuleOutput? { get set }
  func present(with coin: Coin, from: UIViewController)
}
