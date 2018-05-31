//
//  PopupPostProcessFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PopupPostProcessFactory {
  
  let state: PopupState
  let pushService: PushNetworkServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(state: PopupState, pushService: PushNetworkServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.state = state
    self.pushService = pushService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func create() -> PopupPostProcessProtocol {
    switch state {
    case .touchId:
      return PopupTouchPostProcess()
    case .txSent:
      return PopupNoPostProcess()
    case .push:
      let pushProcess = PopupPushPostProcess.shared
      pushProcess.pushService = pushService
      pushProcess.walletDataStoreService = walletDataStoreService
      return pushProcess
    }
  }
  
}
