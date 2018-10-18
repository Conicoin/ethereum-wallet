// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol BalanceInteractorInput: class {
  func getCoin()
  func getBalance()
  func getWalletFromDataBase()
  func getTokensFromDataBase()
  func getEthereumFromNetwork(address: String)
  func getTokensFromNetwork(address: String)
  func updateRates()
}
