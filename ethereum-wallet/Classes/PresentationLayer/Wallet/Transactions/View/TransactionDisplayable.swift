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
  var isIncoming: Bool! { get }
  var isError: Bool! { get }
  var isPending: Bool! { get }
  var from: String! { get }
  var to: String! { get }
  var amount: Currency! { get }
  
  var address: String { get }
  var timestamp: Date! { get }
  var value: String { get }
  var valueColor: UIColor { get }
  var isTokenTransfer: Bool! { get }
  var time: String { get }
  var txHash: String! { get }
}

extension Transaction: TransactionDisplayable {
  var address: String {
    return isIncoming ? from : to
  }
  
  var time: String {
    return isPending ? Localized.transactionsPending() : timestamp.dayDifference()
  }
  
  var value: String {
    return isIncoming ? "+ \(amount.amountString)" : "- \(amount.amountString)"
  }
  
  var valueColor: UIColor {
    return isIncoming ? Theme.Color.green : Theme.Color.red
  }
  
}

extension TokenTransaction: TransactionDisplayable {
  var address: String {
    return isIncoming ? from : to
  }
  
  var time: String {
    return isPending ? Localized.transactionsPending() : timestamp.dayDifference()
  }

  var value: String {
    return isIncoming ? "+ \(amount.amountString)" : "- \(amount.amountString)"
  }
  
  var valueColor: UIColor {
    return isIncoming ? Theme.Color.green : Theme.Color.red
  }
  
}
