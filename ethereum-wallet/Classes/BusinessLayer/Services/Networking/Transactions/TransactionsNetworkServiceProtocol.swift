// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TransactionsNetworkServiceProtocol {
  func getTransactions(address: String, page: Int, limit: Int, queue: DispatchQueue, result: @escaping (Result<[Transaction]>) -> Void)
}
