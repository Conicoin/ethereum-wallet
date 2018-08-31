// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class PopupTouchState: PopupStateProtocol {
  let resource: PopupResource
  let title: String
  let description: String
  let confirmTitle: String
  let skipTitle: String?
  let isSkipActive: Bool
  
  init() {
    self.resource = .image(name: "PopupTouchID")
    self.title = Localized.popupTouchTitle()
    self.description = Localized.popupTouchDescription()
    self.confirmTitle = Localized.popupTouchConfirm()
    self.skipTitle = Localized.commonNotNow()
    self.isSkipActive = true
  }

}
