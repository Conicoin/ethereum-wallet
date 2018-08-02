//
//  ImportStateFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
