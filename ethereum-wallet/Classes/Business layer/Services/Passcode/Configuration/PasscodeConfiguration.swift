//
//  PasscodeConfiguration.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeConfiguration: PasscodeConfigurationProtocol {
  
  let repository: PasscodeRepositoryProtocol
  let passcodeLength = 6
  let shouldRequestTouchIDImmediately = false
  let maximumInccorectPasscodeAttempts = 5
  var isTouchIDAllowed = true
  
  init(repository: PasscodeRepositoryProtocol) {
    self.repository = repository
  }

}
