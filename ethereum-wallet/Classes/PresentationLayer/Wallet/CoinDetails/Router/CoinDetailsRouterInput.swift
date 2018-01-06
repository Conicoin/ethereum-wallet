//
//  CoinDetailsCoinDetailsRouterInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol CoinDetailsRouterInput: class {
  func presentSend(for coin: Coin, from: UIViewController)
  func presentReceive(for coin: Coin, from: UIViewController)
}
