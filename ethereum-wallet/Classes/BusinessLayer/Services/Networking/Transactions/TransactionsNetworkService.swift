// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class TransactionsNetworkService: NetworkLoadable, TransactionsNetworkServiceProtocol  {
  
  func getTransactions(address: String, queue: DispatchQueue, result: @escaping (Result<[Transaction]>) -> Void) {
    loadArray(request: API.Etherscan.transactions(address: address), keyPath: "result", queue: queue, completion: result)
  }
  
  func getTokenTransactions(address: String, queue: DispatchQueue, result: @escaping (Result<[Transaction]>) -> Void) {
    loadArray(request: API.Etherscan.tokenTransactions(address: address), keyPath: "result", queue: queue, completion: result)
  }

}
