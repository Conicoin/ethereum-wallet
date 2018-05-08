//
//  PopupTouchState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

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
    self.skipTitle = Localized.popupNotNow()
    self.isSkipActive = true
  }

}
