// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UserNotifications

class PopupPushPostProcess: PopupPostProcessProtocol {
  
  let pushService: PushServiceProtocol
  
  init(pushService: PushServiceProtocol) {
    self.pushService = pushService
  }
  
  func onConfirm(_ completion: @escaping (Result<Bool>) -> Void) {
    pushService.registerForRemoteNotifications(completion)
  }
  
}

