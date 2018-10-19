// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

protocol TransactionFactoryProtocol {
  func buildTransaction(with info: TransactionInfo, type: CoinType) throws -> GethTransaction
}
