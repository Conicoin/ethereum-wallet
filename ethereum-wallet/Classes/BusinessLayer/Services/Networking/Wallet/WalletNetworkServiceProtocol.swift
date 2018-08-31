// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol WalletNetworkServiceProtocol {
  func getBalance(address: String, queue: DispatchQueue, result: @escaping (Result<String>) -> Void)
}
