//
//  PasscodePostProcessFabric.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodePostProcessFactory {
  
  let passcodeState: PasscodeState
  let keychainService: KeystoreServiceProtocol
  let walletDataStoreService: WalletDataStoreService
  
  init(passcodeState: PasscodeState, keychainService: KeystoreServiceProtocol, walletDataStoreService: WalletDataStoreService) {
    self.passcodeState = passcodeState
    self.keychainService = keychainService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func create() -> PasscodePostProcessProtocol {
    switch passcodeState {
    case .set(let onSuccess):
      return PasscodeNewPostProcess(onSuccess: onSuccess, keystoreService: keychainService, walletDataStoreService: walletDataStoreService)
    case .restore(let onSuccess):
      return PasscodeRestorePostProcess(onSuccess: onSuccess, keystoreService: keychainService, walletDataStoreService: walletDataStoreService)
    case .enter(let onSuccess):
      return PasscodeEnterPostProcess(onSuccess: onSuccess)
    case .change(let onSuccess):
      return PasscodeEnterPostProcess(onSuccess: onSuccess)
    }
  }

}
