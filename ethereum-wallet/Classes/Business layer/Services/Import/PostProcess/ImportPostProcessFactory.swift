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

  init(state: ImportState, keystore: KeystoreServiceProtocol) {
    self.state = state
  }
  
  func create() -> ImportPostProcessProtocol {
    switch state {
    case .jsonKey:
      return ImportJsonPostProcess()
    case .privateKey:
      return ImportPrivatePostProcess()
    }
  }

}
