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
    case .backup:
      return EnterPinState(allowCancellation: true, title: Localized.pinBackupTitle(), touchIdReason: Localized.pinTouchIDReason())
    case .exit:
      return EnterPinState(allowCancellation: true, title: Localized.pinExitTitle(), touchIdReason: nil)
    case .set:
      return NewPinState()
    case .change:
      return ChangePinState()
    case .restoreJson:
      return CustomPinState(allowCancellation: true, touchIdReason: nil, title: Localized.pinRestoreTitle())
    case .restorePrivate:
      return CustomPinState(allowCancellation: true, touchIdReason: nil, title: Localized.pinSetTitle())
    case .send(let amount, let address):
      let title = Localized.pinConfirmPayment(amount, address)
      return EnterPinState(allowCancellation: true, title: title, touchIdReason: title)
    case .lock:
      return EnterPinState(allowCancellation: false, title: Localized.pinLockTitle(), touchIdReason: nil)
    }
  }
  
}
