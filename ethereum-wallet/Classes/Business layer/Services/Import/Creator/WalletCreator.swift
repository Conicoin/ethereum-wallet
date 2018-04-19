//
//  WalletCreator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletCreator: WalletCreatorProtocol {
  
  let walletManager: WalletManagerProtocol
  
  init(walletManager: WalletManagerProtocol) {
    self.walletManager = walletManager
  }
  
  func createWallet(with passcode: String) throws {
    try walletManager.createWallet(passphrase: passcode)
  }
  
}
