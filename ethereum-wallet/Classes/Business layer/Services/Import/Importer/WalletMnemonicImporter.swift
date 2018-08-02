//
//  WalletMnemonicImporter.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletMnemonicImporter: WalletImporterProtocol {
  
  let walletManager: WalletManagerProtocol
  
  init(walletManager: WalletManagerProtocol) {
    self.walletManager = walletManager
  }
  
  func importKey(_ key: Data, passcode: String) throws {
    guard let string = String(data: key, encoding: .utf8) else {
      throw Errors.invalidMnemonic
    }
    let mnemonic = string.components(separatedBy: " ")
    try walletManager.importWallet(mnemonic: mnemonic, passphrase: passcode)
  }
  
  enum Errors: Error {
    case invalidMnemonic
  }

}
