// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class ImportStateFactory {
    
    let state: ImportState
    
    init(state: ImportState) {
        self.state = state
    }
    
    func create() -> ImportStateProtocol {
        switch state {
        case .jsonKey:
            return ImportJsonKeyState()
        case .privateKey:
            return ImportPrivateKeyState()
        case .mnemonic:
          return ImportMnemonicState()
        }
    }

}
