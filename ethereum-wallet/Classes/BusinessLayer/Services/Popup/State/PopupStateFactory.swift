// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class PopupStateFactory {
  
  let state: PopupState
  
  init(state: PopupState) {
    self.state = state
  }
  
  func create() -> PopupStateProtocol {
    switch state {
    case .touchId:
      return PopupTouchState(biometryService: BiometryService())
    case .txSent(let amount, let address):
      return PopupTxSentState(amount: amount, address: address)
    case .push:
      return PopupPushState()
    }
  }

}
