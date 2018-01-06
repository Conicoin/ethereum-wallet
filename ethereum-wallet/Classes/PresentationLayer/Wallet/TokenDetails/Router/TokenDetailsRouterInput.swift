//
//  TokenDetailsTokenDetailsRouterInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 14/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


protocol TokenDetailsRouterInput: class {
  func presentSend(for token: Token, from: UIViewController)
  func presentReceive(for token: Token, from: UIViewController)
}
