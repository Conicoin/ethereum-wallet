//
//  TxIndex.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 26/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

struct TxIndex {
  var address: String!
  var status: String?
  var time: Date!
  var isIncoming: Bool!
  var amount: String!
  var txHash: String!
  var imageName: String!
  var rawAmount: Double!
}

// MARK: - RealmMappable

extension TxIndex: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmTransaction) -> TxIndex {
    let isPending = object.isPending
    let isError = object.isError
    let isIncoming = object.isIncoming
    let to = object.to
    let from = object.from
    
    var amount: Currency!
    if let tokenMeta = object.token {
      amount = TokenValue(object.amount, name: tokenMeta.name, iso: tokenMeta.iso)
    } else {
      amount = Ether(object.amount)
    }
    
    var tx = TxIndex()
    
    if isError {
      tx.status = Localized.transactionsError()
    } else if isPending {
      tx.status = Localized.transactionsPending()
    } else {
      tx.status = nil
    }
    
    if isError {
      tx.imageName = "TxError"
    } else {
      tx.imageName = isIncoming ? "TxReceived" : "TxSent"
    }

    tx.address = isIncoming ? from : to
    tx.amount = isIncoming ? "+ \(amount.amountString)" : "- \(amount.amountString)"
    tx.isIncoming = isIncoming
    tx.time = object.timestamp
    tx.txHash = object.txHash
    return tx
  }
  
  func mapToRealmObject() -> RealmTransaction {
    fatalError("Mapping to RealmObject is not implemented")
  }
  
}
