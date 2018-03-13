//
//  PasscodeEnterPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeEnterPostProcess: PasscodePostProcessProtocol {
  
  let onSuccess: () -> Void
  
  init(onSuccess: @escaping () -> Void) {
    self.onSuccess = onSuccess
  }
  
  func perform(with passphrase: String) throws {
    onSuccess()
  }
  
}
