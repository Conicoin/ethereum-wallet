//
//  WalletImporterFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletImporterFactory {
  
  let walletManager: WalletManagerProtocol
  
  init(walletManager: WalletManagerProtocol) {
    self.walletManager = walletManager
  }
  
  func create(_ state: ImportState) -> WalletImporterProtocol {
    switch state {
    case .jsonKey:
      return WalletJsonImporter(walletManager: walletManager)
    case .privateKey:
      return WalletPrivateImporter(walletManager: walletManager)
    }
  }
  
}
