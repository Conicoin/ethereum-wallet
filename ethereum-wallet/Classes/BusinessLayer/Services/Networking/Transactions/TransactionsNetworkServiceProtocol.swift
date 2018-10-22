// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TransactionsNetworkServiceProtocol {
  func getTransactions(address: String, queue: DispatchQueue, result: @escaping (Result<[Transaction]>) -> Void)
  func getTokenTransactions(address: String, queue: DispatchQueue, result: @escaping (Result<[Transaction]>) -> Void)
}
