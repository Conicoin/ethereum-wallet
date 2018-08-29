// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class PopupTxSentState: PopupStateProtocol {
  let resource: PopupResource
  let title: String
  let description: String
  let confirmTitle: String
  let skipTitle: String?
  let isSkipActive: Bool
  
  init(amount: String, address: String) {
    resource = .animation(name: "LottiCheckmark")
    title = Localized.popupTxSentTitle(amount)
    description = address
    confirmTitle = Localized.popupTxSentConfirm()
    skipTitle = nil
    isSkipActive = false
  }

}
