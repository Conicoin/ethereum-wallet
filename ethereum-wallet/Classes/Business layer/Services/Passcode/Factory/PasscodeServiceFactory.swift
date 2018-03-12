//
//  PasscodeServiceFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PasscodeServiceFactory {
  
  static func create(with passcodeState: PasscodeState) -> PasscodeServiceProtocol {
    let state = passcodeState.getState()
    let repository = PasscodeRepository()
    let configuration = PasscodeConfiguration(repository: repository)
    let passcodeService = PasscodeService(state: state, configuration: configuration)
    return passcodeService
  }

}
