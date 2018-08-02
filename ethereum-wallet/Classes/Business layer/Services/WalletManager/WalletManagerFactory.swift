//
//  WalletManagerFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 19/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class WalletManagerFactory {
  
  func create() -> WalletManagerProtocol {
    let walletManager = WalletManager(walletDataStoreService: WalletDataStoreService(),
                                      coinDataStoreService: CoinDataStoreService(),
                                      keystoreService: KeystoreService(),
                                      mnemonicService: MnemonicService())
    return walletManager
  }

}
