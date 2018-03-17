//
//  ImportPostProcessFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class ImportPostProcessFactory {
  
  let state: ImportState
  let keystore: KeystoreServiceProtocol

  init(state: ImportState, keystore: KeystoreServiceProtocol) {
    self.state = state
    self.keystore = keystore
  }
  
  func create() -> ImportPostProcessProtocol {
    switch state {
    case .jsonKey:
      return ImportJsonPostProcess(keystore: keystore)
    case .privateKey:
      return ImportPrivatePostProcess()
    }
  }

}
