//
//  PinPostProcessFabric.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PinPostProcessFactory {
  
  let keychainService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreService
  
  init(keychainService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreService) {
    self.keychainService = keychainService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func create(with state: PinState) -> PinPostProcessProtocol {
    switch state {
    case .set:
      return PinNewPostProcess(keystoreService: keychainService, walletDataStoreService: walletDataStoreService)
    case .restoreJson(let key):
      return PinRestoreJsonPostProcess(key: key, keystoreService: keychainService, walletDataStoreService: walletDataStoreService)
    case .restorePrivate(let key):
      return PinRestorePrivatePostProcess(key: key, keystoreService: keychainService, walletDataStoreService: walletDataStoreService)
    case .backup(let completion):
      return PinEnterPostProcess(completion: completion)
    case .exit(let completion):
      return PinEnterPostProcess(completion: completion)
    case .change:
      return PinNoPostProcess()
    }
  }

}
