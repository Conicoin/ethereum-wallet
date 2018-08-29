// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol GasServiceProtocol {
  
  /// EstimateGas tries to estimate the gas needed to execute a specific transaction based on
  /// the current pending state of the backend blockchain. There is no guarantee that this is
  /// the true gas limit requirement as other transactions may be added or removed by miners,
  /// but it should provide a basis for setting a reasonable default.
  ///
  /// - Returns: Decimal GasLimit
  func getSuggestedGasLimit(from: String, to: String, amount: Decimal, settings: SendSettings, result: @escaping (Result<Decimal>) -> Void)

  /// SuggestGasPrice retrieves the currently suggested gas price to allow a timely
  /// execution of a transaction.
  ///
  /// - Returns: Int64 GasPrice
  func getSuggestedGasPrice(result: @escaping (Result<Decimal>) -> Void)
}
