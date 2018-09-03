// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class TransactionsNetworkService: NetworkLoadable, TransactionsNetworkServiceProtocol  {
  
  func getTransactions(address: String, page: Int, limit: Int, queue: DispatchQueue, result: @escaping (Result<[Transaction]>) -> Void) {
    loadArray(request: API.Transactions.transactions(address: address, page: page, limit: limit), keyPath: "docs", queue: queue, completion: result)
  }

}
