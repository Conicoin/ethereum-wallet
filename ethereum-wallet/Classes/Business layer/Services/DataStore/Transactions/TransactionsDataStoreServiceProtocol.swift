// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TransactionsDataStoreServiceProtocol {
  func markAndSaveTransactions(_ transactions: [Transaction], address: String)
  func observe(updateHandler: @escaping ([Transaction]) -> Void)
  func observe(token: Token, updateHandler: @escaping ([Transaction]) -> Void)
  func save(_ transaction: Transaction)
}
