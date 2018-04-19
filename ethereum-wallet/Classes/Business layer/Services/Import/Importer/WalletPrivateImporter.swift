//
//  WalletPrivateImporter.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletPrivateImporter: WalletImporterProtocol {
  
  let walletManager: WalletManagerProtocol
  
  init(walletManager: WalletManagerProtocol) {
    self.walletManager = walletManager
  }
  
  func importKey(_ key: Data, passcode: String) throws {
    try walletManager.importWallet(privateKey: key, passphrase: passcode)
  }
  
}
