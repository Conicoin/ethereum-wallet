// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol BalanceInteractorOutput: class {
  func didReceiveWallet(_ wallet: Wallet)
  func didReceiveTokens(_ viewModels: [TokenViewModel])
  func didReceiveBalance(_ balance: BalanceViewModel)
  func didFailedWalletReceiving(with error: Error)
  func didFailedTokensReceiving(with error: Error)
}
