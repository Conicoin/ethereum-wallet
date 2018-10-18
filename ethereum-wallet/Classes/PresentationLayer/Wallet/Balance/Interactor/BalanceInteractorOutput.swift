// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol BalanceInteractorOutput: class {
  func didReceiveWallet(_ wallet: Wallet)
  func didReceiveTokens(_ tokens: [Token])
  func didReceiveBalance(_ balance: Currency)
  func didReceiveCoin(_ coin: Coin)
  func didFailedWalletReceiving(with error: Error)
  func didFailedTokensReceiving(with error: Error)
}
