// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

enum PopupState {
  case push
  case touchId
  case txSent(amount: String, address: String)
}

protocol PopupStateProtocol {
  var resource: PopupResource { get }
  var title: String { get }
  var description: String { get }
  var confirmTitle: String { get }
  var skipTitle: String? { get }
  var isSkipActive: Bool { get }
}

enum PopupResource {
  case image(name: String)
  case animation(name: String)
}
