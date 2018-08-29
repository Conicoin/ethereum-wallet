// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

enum PinState {
  case exit
  case backup
  case set
  case change
  case restoreJson
  case restorePrivate
  case restoreMnemonic
  case send(amount: String, address: String)
  case lock
}

protocol PinStateProtocol {
  
  var title: String { get }
  var isCancellableAction: Bool { get }
  var isTouchIDAllowed: Bool { get }
  var touchIdReason: String? { get }
  var isTermsShown: Bool { get }
  
  mutating func acceptPin(_ pin: [String], fromLock lock: PinServiceProtocol)
}

extension PinStateProtocol {
  
  var touchIdReason: String? {
    return nil
  }
  
  var isTouchIDAllowed: Bool {
    return touchIdReason != nil
  }
  
}
