// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

protocol TransactionServiceProtocol {
  /// Send transaction
  ///
  /// - Parameters:
  ///   - info: TransactionInfo object containing: amount, address, gas limit
  ///   - passphrase: Password to unlock wallet
  func sendTransaction(with info: TransactionInfo, passphrase: String, result: @escaping (Result<GethTransaction>) -> Void)
}
