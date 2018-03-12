//
//  PasscodeRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeRepository: PasscodeRepositoryProtocol {
  
  var hasPasscode: Bool {
    let keychain = Keychain()
    return keychain.passphrase != nil
  }
  
  var passcode: [String]? {
    let keychain = Keychain()
    guard let passphrase = keychain.passphrase else {
      return nil
    }
    return passphrase.map { String($0) }
  }
  
  func savePasscode(_ passcode: [String]) {
    let pin = passcode.joined()
    let keychain = Keychain()
    keychain.passphrase = pin
  }
  
  func deletePasscode() {
    let keychain = Keychain()
    keychain.passphrase = nil
  }

}
