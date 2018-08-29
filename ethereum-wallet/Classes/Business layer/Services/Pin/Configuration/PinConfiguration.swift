// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
