//
//  PopupStateProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

enum PopupState {
  case touchId
  case txSent(amount: String, address: String)
}

protocol PopupStateProtocol {
  var imageName: String { get }
  var title: String { get }
  var description: String { get }
  var confirmTitle: String { get }
  var skipTitle: String? { get }
  var isSkipActive: Bool { get }
}
