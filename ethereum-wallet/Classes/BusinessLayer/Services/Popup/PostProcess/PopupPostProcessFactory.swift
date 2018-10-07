// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class PopupPostProcessFactory {
  
  let pushService: PushServiceProtocol
  let biometryService: BiometryServiceProtocol
  
  init(pushService: PushServiceProtocol, biometryService: BiometryServiceProtocol) {
    self.pushService = pushService
    self.biometryService = biometryService
  }
  
  func create(_ state: PopupState) -> PopupPostProcessProtocol {
    switch state {
    case .touchId:
      return PopupTouchPostProcess(biometryService: biometryService)
    case .txSent:
      return PopupNoPostProcess()
    case .push:
      return PopupPushPostProcess(pushService: pushService)
    }
  }
  
}
