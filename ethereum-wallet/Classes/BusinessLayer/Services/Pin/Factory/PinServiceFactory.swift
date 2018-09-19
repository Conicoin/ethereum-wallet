// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class PinServiceFactory {
  
  static func create(with pinState: PinState, delegate: PinServiceDelegate) -> PinServiceProtocol {
    let state = PinStateFactory(state: pinState).create()
    let keychain = Keychain()
    let repository = PinRepository(keychain: keychain)
    let configuration = PinConfiguration(repository: repository)
    let biometryService = BiometryService()
    let pinService = PinService(state: state, configuration: configuration, biometryService: biometryService)
    pinService.delegate = delegate
    return pinService
  }

}
