// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class PopupNoPostProcess: PopupPostProcessProtocol {
  
  func onConfirm(_ completion: @escaping (Result<Bool>) -> Void) {
    completion(.success(true))
  }

}
