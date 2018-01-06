// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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


import Geth
import Alamofire

protocol TransactionServiceProtocol {
  /// Send transaction
  ///
  /// - Parameters:
  ///   - amount: Amount ot send base 16 string
  ///   - to: Recepient address
  ///   - gasLimit: Gas limit hex string
  ///   - passphrase: Password to unlock wallet
  func sendTransaction(amountHex: String, to: String, gasLimitHex: String, passphrase: String, result: @escaping (Result<GethTransaction>) -> Void)
  func sendTokenTransaction(contractAddress: String, to: String, amountHex: String, passphrase: String, result: @escaping (Result<GethTransaction>) -> Void)
}
