// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol BalanceInteractorOutput: class {
  func didReceiveWallet(_ wallet: Wallet)
  func didReceiveCoins(_ coins: [Coin])
  func didReceiveTokens(_ tokens: [Token])
  func didFailedWalletReceiving(with error: Error)
  func didFailedTokensReceiving(with error: Error)
}
