//
//  PopupStateFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PopupStateFactory {
  
  let state: PopupState
  
  init(state: PopupState) {
    self.state = state
  }
  
  func create() -> PopupStateProtocol {
    switch state {
    case .touchId:
      return PopupTouchState()
    case .txSent(let amount, let address):
      return PopupTxSentState(amount: amount, address: address)
    }
  }

}
