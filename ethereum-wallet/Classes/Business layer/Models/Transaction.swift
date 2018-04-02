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
import Geth
import ObjectMapper

struct Transaction {
  var txHash: String!
  var to: String!
  var from: String!
  var amount: Currency!
  var timestamp: Date!
  var isIncoming: Bool!
  var isPending: Bool!
  var isError: Bool!
  var isTokenTransfer: Bool!
  var gasUsed: String!
  var gasPrice: String!
  
  static func mapFromGethTransaction(_ object: GethTransaction, time: TimeInterval) -> Transaction {
    var transaction = Transaction()
    transaction.txHash = object.getHash().getHex()
    transaction.to = object.getTo().getHex()
    transaction.from = "" 
    transaction.amount = Ether(weiString: object.getValue().string()!)
    transaction.timestamp = Date(timeIntervalSince1970: time)
    transaction.isPending = false
    transaction.isError = false
    transaction.isTokenTransfer = false
    transaction.gasUsed = ""
    transaction.gasPrice = ""
    return transaction
  }
  
}

// MARK: - RealmMappable

extension Transaction: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTransaction) -> Transaction {
    var transaction = Transaction()
    transaction.txHash = object.txHash
    transaction.to = object.to
    transaction.from = object.from
    transaction.amount = Ether(object.amount)
    transaction.timestamp = object.timestamp
    transaction.isIncoming = object.isIncoming
    transaction.isPending = object.isPending
    transaction.isError = object.isError
    transaction.isTokenTransfer = object.isTokenTransfer
    transaction.gasUsed = object.gasUsed
    transaction.gasPrice = object.gasPrice
    return transaction
  }
  
  func mapToRealmObject() -> RealmTransaction {
    let realmObject = RealmTransaction()
    realmObject.txHash = txHash
    realmObject.to = to
    realmObject.from = from
    realmObject.amount = amount.raw.string
    realmObject.timestamp = timestamp
    realmObject.isIncoming = isIncoming
    realmObject.isPending = isPending
    realmObject.isError = isError
    realmObject.isTokenTransfer = isTokenTransfer
    realmObject.gasUsed = gasUsed
    realmObject.gasPrice = gasPrice
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension Transaction: ImmutableMappable {
  
  init(map: Map) throws {
    txHash = try map.value("hash")
    to = try map.value("to")
    from = try map.value("from")
    gasUsed = try map.value("gasUsed")
    gasPrice = try map.value("gasPrice")
    let amountString: String = try map.value("value")
    amount = Ether(weiString: amountString)
    timestamp = try map.value("timeStamp", using: DateTransform())
    let isErrorString: String = try map.value("isError")
    isError = Bool(isErrorString)
    isPending = false
    isTokenTransfer = false
  }
  
}
