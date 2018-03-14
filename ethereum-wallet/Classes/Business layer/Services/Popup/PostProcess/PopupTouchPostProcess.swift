//
//  PopupTouchPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PopupTouchPostProcess: PopupPostProcessProtocol {
  
  let state: PopupState
  
  init(state: PopupState) {
    self.state = state
  }
  
  func onConfirm() {
    
  }
  
  func onSkip() {
    
  }
  
}
