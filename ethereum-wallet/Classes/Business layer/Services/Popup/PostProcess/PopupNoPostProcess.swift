//
//  PopupNoPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class PopupNoPostProcess: PopupPostProcessProtocol {
  
  func onConfirm(_ completion: @escaping (Result<Bool>) -> Void) {
    completion(.success(true))
  }

}
