// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

fileprivate extension BiometryType {
  var imageName: String {
    switch self {
    case .faceId:
      return R.image.popupFaceID.name
    default:
      return R.image.popupTouchID.name
    }
  }
}

class PopupTouchState: PopupStateProtocol {
  let resource: PopupResource
  let title: String
  let description: String
  let confirmTitle: String
  let skipTitle: String?
  let isSkipActive: Bool
  
  init(biometryService: BiometryServiceProtocol) {
    let biometry = biometryService.biometry
    self.resource = .image(name: biometry.imageName)
    self.title = Localized.popupTouchTitle(biometry.label)
    self.description = Localized.popupTouchDescription(biometry.label)
    self.confirmTitle = Localized.popupTouchConfirm(biometry.label)
    self.skipTitle = Localized.commonNotNow()
    self.isSkipActive = true
  }

}
