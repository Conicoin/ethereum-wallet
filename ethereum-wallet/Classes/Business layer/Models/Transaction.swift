//
//  Transaction.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation
import Geth

struct Transaction {
  var txHash: String!
  var to: String!
  var amount: Int!
  
  static func mapFromGethTransaction(_ object: GethTransaction) -> Transaction {
    var transaction = Transaction()
    transaction.txHash = object.getHash().getHex()
    transaction.to = object.getTo().getHex()
    transaction.amount = Int(object.getValue().getInt64())
    return transaction
  }
  
}

// MARK: - RealmMappable

extension Transaction: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTransaction) -> Transaction {
    var transaction = Transaction()
    transaction.txHash = object.txHash
    transaction.to = object.to
    transaction.amount = object.amount
    return transaction
  }
  
  func mapToRealmObject() -> RealmTransaction {
    let realmObject = RealmTransaction()
    realmObject.txHash = txHash
    realmObject.to = to
    realmObject.amount = amount
    return realmObject
  }
  
}
