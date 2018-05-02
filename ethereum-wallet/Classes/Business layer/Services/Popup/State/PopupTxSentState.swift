//
//  PopupTxSentState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 12/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class PopupTxSentState: PopupStateProtocol {
  
  let imageName: String
  let title: String
  let description: String
  let confirmTitle: String
  let skipTitle: String?
  let isSkipActive: Bool
  
  init(amount: String, address: String) {
    imageName = "PopupCheckmark"
    title = Localized.popupTxSentTitle(amount)
    description = address
    confirmTitle = Localized.popupTxSentConfirm()
    skipTitle = nil
    isSkipActive = false
  }

}
