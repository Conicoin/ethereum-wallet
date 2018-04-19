//
//  PopupPostProcessFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PopupPostProcessFactory {
    
    let state: PopupState
    
    init(state: PopupState) {
        self.state = state
    }
    
    func create() -> PopupPostProcessProtocol {
        switch state {
        case .touchId:
            return PopupTouchPostProcess()
        case .txSent:
            return PopupNoPostProcess()
      }
    }

}
