//
//  WalletImporterFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 23/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class WalletImporterFactory {
  
  let keystoreService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(keystoreService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.keystoreService = keystoreService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func create(_ state: ImportState) -> WalletImporterProtocol {
    switch state {
    case .jsonKey:
      return WalletJsonImporter(keystoreService: keystoreService, walletDataStoreService: walletDataStoreService)
    case .privateKey:
      return WalletPrivateImporter(keystoreService: keystoreService, walletDataStoreService: walletDataStoreService)
    }
  }
  
}
