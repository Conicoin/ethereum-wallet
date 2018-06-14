//
//  PopupPostProcessFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
