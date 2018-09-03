// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class WalletManagerFactory {
  
  func create() -> WalletManagerProtocol {
    let walletManager = WalletManager(keyhcain: Keychain(),
                                      walletDataStoreService: WalletDataStoreService(),
                                      coinDataStoreService: CoinDataStoreService(),
                                      keystoreService: KeystoreService(),
                                      mnemonicService: MnemonicService())
    return walletManager
  }

}
