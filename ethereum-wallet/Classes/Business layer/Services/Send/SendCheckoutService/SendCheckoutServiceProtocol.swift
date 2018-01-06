//
//  SendCheckoutService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 06/01/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol SendCheckoutServiceProtocol {
  func checkout(for coin: CoinDisplayable, amount: Decimal, iso: String, fee: Decimal) throws -> SendCheckout
}
