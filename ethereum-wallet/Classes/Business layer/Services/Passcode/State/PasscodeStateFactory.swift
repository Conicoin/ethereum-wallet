//
//  PasscodeState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class PasscodeStateFactory {
  
  let state: PasscodeState
  
  init(state: PasscodeState) {
    self.state = state
  }
  
  func create() -> PasscodeStateProtocol {
    switch state {
    case .enter:
      return EnterPasscodeState(title: Localized.passcodeEnterTitle(), isTouchIDAllowed: true)
    case .set:
      return SetPasscodeState()
    case .change:
      return ChangePasscodeState()
    case .restore:
      return EnterPasscodeState(allowCancellation: true, title: Localized.welcomeRestoreTitle(), isTouchIDAllowed: false)
    }
  }
  
}
