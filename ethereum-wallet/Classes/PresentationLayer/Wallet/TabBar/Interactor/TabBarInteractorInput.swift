//
//  TabBarTabBarInteractorInput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation


protocol TabBarInteractorInput: class {
  func startSynchronization()
  func getTransactions(from block: Int, to: Int)
}
