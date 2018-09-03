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
    tx.from = object.from
    tx.to = object.to
    
    if let meta = object.tokenMeta {
      tx.tokenMeta = TokenMeta.mapFromRealmObject(meta)
      tx.amount = TokenValue(wei: Decimal(object.value), name: meta.name, iso: meta.symbol, decimals: meta.decimals)
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
    realmObject.value = amount.raw.string
    realmObject.from = from
    realmObject.to = to
    realmObject.tokenMeta = tokenMeta?.mapToRealmObject()
    
    return realmObject
  }
  
}

// MARK: - ImmutableMappable

extension Transaction: ImmutableMappable {
  
  init(map: Map) throws {
    txHash = try map.value("id")
    blockNumber = try map.value("blockNumber")
    timeStamp = try map.value("timeStamp", using: DateTransform())
    nonce = try map.value("nonce")
    from = try map.value("from")
    error = try? map.value("error")
    
    let gasString: String = try map.value("gas")
    let gasPriceString: String = try map.value("gasPrice")
    let gasUsedString: String = try map.value("gasUsed")
    self.gas = Decimal(gasString)
    self.gasPrice = Decimal(gasPriceString)
    self.gasUsed = Decimal(gasUsedString)
    
    if let meta: TokenMeta = try? map.value("operations.0.contract") {
      self.tokenMeta = meta
      self.to = try map.value("operations.0.to")
      let value: String = try map.value("operations.0.value")
      self.amount = TokenValue(wei: Decimal(value), name: meta.name, iso: meta.iso, decimals: meta.decimals)
    } else {
      self.to = try map.value("to")
      let value: String = try map.value("value")
      self.amount = Ether(weiString: value)
    }
  }
  
}
