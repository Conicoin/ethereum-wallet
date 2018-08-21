//
//  PinServiceFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PinServiceFactory {
  
  static func create(with pinState: PinState, delegate: PinServiceDelegate) -> PinServiceProtocol {
    let state = PinStateFactory(state: pinState).create()
    let keychain = Keychain()
    let repository = PinRepository(keychain: keychain)
    let configuration = PinConfiguration(repository: repository)
    let pinService = PinService(state: state, configuration: configuration)
    pinService.delegate = delegate
    return pinService
  }

}
