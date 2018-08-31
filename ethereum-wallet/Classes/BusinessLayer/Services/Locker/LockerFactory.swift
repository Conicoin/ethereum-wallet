// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class LockerFactory {
  
  func create() -> LockerProtocol {
    let keychain = Keychain()
    let service = Locker(keychain: keychain)
    return service
  }
  
}
