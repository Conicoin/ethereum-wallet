//
//  PopupPushPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Alamofire
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

