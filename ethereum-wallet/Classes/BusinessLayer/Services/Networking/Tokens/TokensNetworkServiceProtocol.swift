// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TokensNetworkServiceProtocol {
  func getTokens(address: String, queue: DispatchQueue, result: @escaping (Result<[Token]>) -> Void)
}
