//
//  PopupPushPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Alamofire

class PopupPushPostProcess: PopupPostProcessProtocol {
  
  func onConfirm(_ completion: (Result<Bool>) -> Void) {
    completion(.success(true))
  }
  
}

