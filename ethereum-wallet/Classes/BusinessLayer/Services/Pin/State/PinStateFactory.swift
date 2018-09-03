// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
      return CustomPinState(allowCancellation: true, touchIdReason: nil, title: Localized.pinRestoreTitle(), isTermsShown: true)
    case .restorePrivate:
      return CustomPinState(allowCancellation: true, touchIdReason: nil, title: Localized.pinSetTitle(), isTermsShown: true)
    case .restoreMnemonic:
        return CustomPinState(allowCancellation: true, touchIdReason: nil, title: Localized.pinSetTitle(), isTermsShown: true)
    case .send(let amount, let address):
      let title = Localized.pinConfirmPayment(amount, address)
      return EnterPinState(allowCancellation: true, title: title, touchIdReason: title)
    case .lock:
      return EnterPinState(allowCancellation: false, title: Localized.pinLockTitle(), touchIdReason: Localized.pinTouchIDReason())
    }
  }
  
}
