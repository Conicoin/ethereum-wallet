//
//  SendCheckoutServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol SendCheckoutServiceProtocol {
  typealias Checkout = (amount: String, fiatAmount: String, fee: String)
  func checkout(for coin: CoinDisplayable, amount: Decimal, iso: String, fee: Decimal) throws -> Checkout
}
