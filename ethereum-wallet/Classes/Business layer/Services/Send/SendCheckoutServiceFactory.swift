// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class SendCheckoutServiceFactory {
  
  func create(_ type: TransferType) -> SendCheckoutServiceProtocol {
    switch type {
    case .default:
      return SendCoinCheckoutService()
    case .token:
      return SendTokenCheckoutService()
    }
  }
  
}
