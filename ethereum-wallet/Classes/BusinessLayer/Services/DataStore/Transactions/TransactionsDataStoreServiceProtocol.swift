// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TransactionsDataStoreServiceProtocol {
  func find() -> [Transaction]
  func markAndSaveTransactions(_ transactions: [Transaction], address: String, isNormal: Bool)
  func observe(updateHandler: @escaping ([Transaction]) -> Void)
  func observe(token: Token, updateHandler: @escaping ([Transaction]) -> Void)
  func save(_ transaction: Transaction)
}
