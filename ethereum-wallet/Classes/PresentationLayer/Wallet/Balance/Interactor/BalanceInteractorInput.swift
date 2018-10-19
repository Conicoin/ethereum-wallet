// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol BalanceInteractorInput: class {
  func getCoin()
  func getTokens()
  func getWallet()
  func getEthereumFromNetwork(address: String)
  func getTokensFromNetwork(address: String)
}
