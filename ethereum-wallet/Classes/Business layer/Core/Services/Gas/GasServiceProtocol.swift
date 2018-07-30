// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

protocol GasServiceProtocol {
  
  /// EstimateGas tries to estimate the gas needed to execute a specific transaction based on
  /// the current pending state of the backend blockchain. There is no guarantee that this is
  /// the true gas limit requirement as other transactions may be added or removed by miners,
  /// but it should provide a basis for setting a reasonable default.
  ///
  /// - Returns: Decimal GasLimit
  func getSuggestedGasLimit(from: String, to: String, gasPrice: Decimal, amount: Decimal, result: @escaping (Result<Decimal>) -> Void)

  /// SuggestGasPrice retrieves the currently suggested gas price to allow a timely
  /// execution of a transaction.
  ///
  /// - Returns: Int64 GasPrice
  func getSuggestedGasPrice(result: @escaping (Result<Decimal>) -> Void)
}
