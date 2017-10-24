//
//  TabBarTabBarInteractorOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation


protocol TabBarInteractorOutput: class {
  func syncDidUpdateBalance(_ balance: Int64)
  func syncDidFailedWithError(_ error: Error)
  func syncDidChangeProgress(current: Int64, total: Int64)
  func syncDidFinished()
}
