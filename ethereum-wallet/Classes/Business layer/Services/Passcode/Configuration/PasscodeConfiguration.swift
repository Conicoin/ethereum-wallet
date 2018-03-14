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
  let passcodeLength: Int
  let shouldRequestTouchIDImmediately: Bool
  let maximumInccorectPasscodeAttempts: Int
  let isTouchIDAllowed: Bool
  
  init(repository: PasscodeRepositoryProtocol) {
    self.repository = repository
    self.passcodeLength = 6
    self.shouldRequestTouchIDImmediately = false
    self.maximumInccorectPasscodeAttempts = 5
    self.isTouchIDAllowed = Defaults.isTouchIDAllowed
  }

}
