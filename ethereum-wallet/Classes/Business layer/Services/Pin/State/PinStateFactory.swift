//
//  PinState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class PinStateFactory {
  
  let state: PinState
  
  init(state: PinState) {
    self.state = state
  }
  
  func create() -> PinStateProtocol {
    switch state {
    case .enter:
      return EnterPinState(title: Localized.pinEnterTitle())
    case .set:
      return NewPinState()
    case .change:
      return ChangePinState()
    case .restoreJson, .restorePrivate:
      return CustomPinState(allowCancellation: true, isTouchIDAllowed: false, title: Localized.welcomeRestoreTitle())
    }
  }
  
}
