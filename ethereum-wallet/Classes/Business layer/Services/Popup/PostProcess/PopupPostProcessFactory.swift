// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class PopupPostProcessFactory {
  
  let pushService: PushServiceProtocol
  
  init(pushService: PushServiceProtocol) {
    self.pushService = pushService
  }
  
  func create(_ state: PopupState) -> PopupPostProcessProtocol {
    switch state {
    case .touchId:
      return PopupTouchPostProcess()
    case .txSent:
      return PopupNoPostProcess()
    case .push:
      return PopupPushPostProcess(pushService: pushService)
    }
  }
  
}
