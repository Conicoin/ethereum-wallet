//
//  SendCheckoutServiceFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
