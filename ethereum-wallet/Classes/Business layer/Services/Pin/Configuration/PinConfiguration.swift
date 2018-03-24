//
//  PinConfiguration.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PinConfiguration: PinConfigurationProtocol {
  
  let repository: PinRepositoryProtocol
  let pinLength: Int
  let shouldRequestTouchIDImmediately: Bool
  let maximumInccorectPinAttempts: Int
  var isTouchIDAllowed: Bool {
    return Defaults.isTouchIDAllowed
  }
  
  init(repository: PinRepositoryProtocol) {
    self.repository = repository
    self.pinLength = 6
    self.shouldRequestTouchIDImmediately = false
    self.maximumInccorectPinAttempts = 5
  }

}
