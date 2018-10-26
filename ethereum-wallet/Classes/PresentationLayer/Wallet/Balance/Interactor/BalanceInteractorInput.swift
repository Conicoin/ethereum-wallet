// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol BalanceInteractorInput: class {
  func startUpdater()
  func getBalance()
  func getTokens()
  func getWallet()
  func updateBalance()
}
