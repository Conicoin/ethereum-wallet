// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol SendCheckoutServiceProtocol {
  typealias Checkout = (amount: String, total: String, fiatAmount: String, fee: String)
  func checkout(for coin: CoinDisplayable, amount: Decimal, iso: String, fee: Decimal) throws -> Checkout
}
