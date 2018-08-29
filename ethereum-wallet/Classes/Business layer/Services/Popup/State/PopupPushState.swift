// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
