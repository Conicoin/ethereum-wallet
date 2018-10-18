// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class LockerFactory {
  
  let app: Application
  
  init(app: Application) {
    self.app = app
  }
  
  func create() -> LockerProtocol {
    let keychain = Keychain()
    let service = Locker(app: app, keychain: keychain)
    return service
  }
  
}
