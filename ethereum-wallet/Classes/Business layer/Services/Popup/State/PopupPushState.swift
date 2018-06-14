//
//  PopupPushState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class PopupPushState: PopupStateProtocol {
  let resource: PopupResource
  let title: String
  let description: String
  let confirmTitle: String
  let skipTitle: String?
  let isSkipActive: Bool
  
  init() {
    self.resource = .image(name: "PopupPush")
    self.title = Localized.popupPushTitle()
    self.description = Localized.popupPushDescription()
    self.confirmTitle = Localized.popupPushConfirm()
    self.skipTitle = Localized.commonNotNow()
    self.isSkipActive = true
  }
  
}
