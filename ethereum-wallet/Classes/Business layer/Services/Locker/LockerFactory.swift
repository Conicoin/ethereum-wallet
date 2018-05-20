//
//  LockeProviderFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class LockerFactory {
  
  func create() -> LockerProtocol {
    let keychain = Keychain()
    let service = Locker(keychain: keychain)
    return service
  }
  
}
