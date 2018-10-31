// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import RealmSwift

class TransactionsDataStoreService: RealmStorable<Transaction>, TransactionsDataStoreServiceProtocol {
  
  func getTransaction(txHash: String) -> Transaction? {
    return findOne("txHash = '\(txHash)'")
  }
  
  func observe(token: Token, updateHandler: @escaping ([Transaction]) -> Void) {
    super.observe(predicate: "tokenMeta.address = '\(token.address)'", updateHandler: updateHandler)
  }
  
  func markAndSaveTransactions(_ transactions: [Transaction], address: String, isNormal: Bool) {
    var txs = transactions
    for (i, tx) in txs.enumerated() {
      txs[i].isIncoming = tx.to == address
      txs[i].isNormal = isNormal
    }
    save(txs)
  }

}
