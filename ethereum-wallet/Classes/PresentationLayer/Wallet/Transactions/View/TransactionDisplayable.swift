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


import UIKit

protocol TransactionDisplayable {
  var txHash: String! { get }
  var isIncoming: Bool! { get }
  var isError: Bool! { get }
  var isPending: Bool! { get }
  var from: String! { get }
  var to: String! { get }
  var isTokenTransfer: Bool! { get }
  var amount: Currency! { get }
  var totalAmount: String? { get }
  var fee: String? { get }
}

extension Transaction: TransactionDisplayable {
  
  var totalAmount: String? {
    let used = Decimal(gasUsed)
    let price = Decimal(gasPrice)
    let total = Ether((used * price).fromWei() + amount.raw)
    return total.amountString
  }
  
  var fee: String? {
    let used = Decimal(gasUsed)
    let price = Decimal(gasPrice)
    let fee = Ether(weiValue: used * price)
    return fee.amountString
  }
  
}

extension TokenTransaction: TransactionDisplayable {
  
  var totalAmount: String? {
    return nil
  }
  
  var fee: String? {
    return nil
  }
  
}
