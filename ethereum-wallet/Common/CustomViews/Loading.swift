//
//  Loading.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 07/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import PKHUD

class Loading {
  
  static func show() {
    HUD.show(.systemActivity)
  }
  
  static func dismiss() {
    HUD.hide()
  }
  
  static func success() {
    HUD.flash(.success, delay: 1)
  }
  
  static func failure() {
    HUD.flash(.error, delay: 1)
  }
  
  static func dismiss(_ isSuccess: Bool) {
    isSuccess ? Loading.success() : Loading.failure()
  }

}
