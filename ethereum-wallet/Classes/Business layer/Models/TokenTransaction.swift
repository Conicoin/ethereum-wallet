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
import ObjectMapper
import Geth

struct TokenTransaction {
  var txHash: String!
  var to: String!
  var from: String!
  var amount: Currency!
  var type: String!
  var tokenMeta: TokenMeta!
  var timestamp: Date!
  var isIncoming: Bool!
  var isPending: Bool!
  
  static func mapFromGethTransaction(_ object: GethTransaction, time: TimeInterval, token: Token) -> TokenTransaction {
    var transaction = TokenTransaction()
    transaction.txHash = object.getHash().getHex()
    transaction.to = object.getTo().getHex()
    transaction.from = ""
    transaction.timestamp = Date(timeIntervalSince1970: time)
    transaction.isPending = false
    transaction.type = "transfer"
    let tokenMeta = token.getTokenMeta()
    transaction.tokenMeta = tokenMeta
    transaction.amount = TokenValue(weiString: object.getValue().string()!, name: tokenMeta.name, iso: tokenMeta.iso)
    return transaction
  }
}

// MARK: - RealmMappable

extension TokenTransaction: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTokenTransaction) -> TokenTransaction {
    var transaction = TokenTransaction()
    transaction.txHash = object.txHash
    transaction.to = object.to
    transaction.from = object.from
    transaction.type = object.type
    let tokenMeta = TokenMeta.mapFromRealmObject(object.token)
    transaction.tokenMeta = tokenMeta
    transaction.amount = TokenValue(object.amount, name: tokenMeta.name, iso: tokenMeta.iso)
    transaction.timestamp = object.timestamp
    transaction.isIncoming = object.isIncoming
    transaction.isPending = object.isPending
    return transaction
  }
  
  func mapToRealmObject() -> RealmTokenTransaction {
    let realmObject = RealmTokenTransaction()
    realmObject.txHash = txHash
    realmObject.to = to
    realmObject.from = from
    realmObject.type = type
    realmObject.amount = amount.raw.string
    realmObject.timestamp = timestamp
    realmObject.isIncoming = isIncoming
    realmObject.isPending = isPending
    realmObject.token = tokenMeta.mapToRealmObject()
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension TokenTransaction: ImmutableMappable {
  
  init(map: Map) throws {
    txHash = try map.value("transactionHash")
    to = try map.value("to")
    from = try map.value("from")
    type = try map.value("type")
    let amountString: String = try map.value("value")
    amount = Ether(weiString: amountString)
    timestamp = try map.value("timestamp", using: DateTransform())
    guard let tokenInfo = map.JSON["tokenInfo"] as? [String : Any] else {
      throw NetworkError.parseError
    }
    tokenMeta = Mapper<TokenMeta>().map(JSON: tokenInfo)
    isPending = false
  }
  
}
