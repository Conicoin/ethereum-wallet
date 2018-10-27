// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol BalanceInteractorInput: class {
  func startBalanceUpdater()
  func startRatesUpdater()
  func getBalance()
  func getTokens()
  func getWallet()
  func updateBalance()
}
