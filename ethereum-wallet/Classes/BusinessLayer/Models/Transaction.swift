// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import Geth
import ObjectMapper

struct Transaction {
  var txHash: String!
  var blockNumber: Int64!
  var timeStamp = Date()
  var nonce: Int64!
  var from: String!
  var to: String!
  var gas: Decimal!
  var gasPrice: Decimal!
  var gasUsed: Decimal!
  var error: String?
  var amount: Currency!
  var tokenMeta: TokenMeta?
  var isIncoming = false
  var isPending = false
  var isNormal: Bool!
  var input: String!
  
  var value: Currency {
    return tokenMeta?.value ?? amount
  }
  
  var isTokenTransfer: Bool {
    return tokenMeta != nil
  }
}

// MARK: - RealmMappable

extension Transaction: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTransaction) -> Transaction {
    var tx = Transaction()
    tx.txHash = object.txHash
    tx.blockNumber = object.blockNumber
    tx.timeStamp = object.timeStamp
    tx.nonce = object.nonce
    tx.gas = Decimal(object.gas)
    tx.gasPrice = Decimal(object.gasPrice)
    tx.gasUsed = Decimal(object.gasUsed)
    tx.error = object.error
    tx.isPending = object.isPending
    tx.isIncoming = object.isIncoming
    tx.isNormal = object.isNormal
    tx.from = object.from
    tx.to = object.to
    tx.input = object.input
    
    if let meta = object.tokenMeta {
      tx.tokenMeta = TokenMeta.mapFromRealmObject(meta)
      tx.amount = Ether()
    } else {
      tx.amount = Ether(weiString: object.value)
    }

    return tx
  }
  
  func mapToRealmObject() -> RealmTransaction {
    let realmObject = RealmTransaction()
    realmObject.txHash = txHash
    realmObject.blockNumber = blockNumber
    realmObject.timeStamp = timeStamp
    realmObject.nonce = nonce
    realmObject.gas = gas.string
    realmObject.gasPrice = gasPrice.string
    realmObject.gasUsed = gasUsed.string
    realmObject.error = error
    realmObject.isPending = isPending
    realmObject.isIncoming = isIncoming
    realmObject.isNormal = isNormal
    realmObject.value = amount.raw.string
    realmObject.from = from
    realmObject.to = to
    realmObject.tokenMeta = tokenMeta?.mapToRealmObject()
    realmObject.input = input
    
    let key = isNormal ? "normal" : "token"
    realmObject.primaryKeyConstant = "\(txHash!)-\(key)"
    
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension Transaction: ImmutableMappable {
  
  init(map: Map) throws {
    txHash = try map.value("hash")
    blockNumber = Int64(try map.value("blockNumber") as String) ?? 0
    timeStamp = try map.value("timeStamp", using: DateTransform())
    nonce = Int64(try map.value("nonce") as String) ?? 0
    from = try map.value("from")
    to = try map.value("to")
    gas = Decimal(try map.value("gas") as String)
    gasPrice = Decimal(try map.value("gasPrice") as String)
    gasUsed = Decimal(try map.value("gasUsed") as String)
    
    if let isError = try? map.value("isError") as String, isError == "1" {
      error = "Transaction failed"
    }
    
    if let meta = try? TokenMeta(map: map) {
      tokenMeta = meta
      amount = Ether()
    } else {
      let value = Decimal(try map.value("value") as String)
      amount = Ether(weiValue: value)
    }
    
    input = try map.value("input")
  }
  
}
