//
//  PinRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PinRepository: PinRepositoryProtocol {
  
  var hasPin: Bool {
    let keychain = Keychain()
    return keychain.passphrase != nil
  }
  
  var pin: [String]? {
    let keychain = Keychain()
    guard let passphrase = keychain.passphrase else {
      return nil
    }
    return passphrase.map { String($0) }
  }
  
  func savePin(_ pin: [String]) {
    let pin = pin.joined()
    let keychain = Keychain()
    keychain.passphrase = pin
  }
  
  func deletePin() {
    let keychain = Keychain()
    keychain.passphrase = nil
  }

}
