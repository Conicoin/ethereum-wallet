// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol TokensNetworkServiceProtocol {
  func getTokens(address: String, queue: DispatchQueue, result: @escaping (Result<[Token]>) -> Void)
  func getBalanceForToken(contractAddress: String, address: String, queue: DispatchQueue, result: @escaping (Result<TokenBalance>) -> Void)
}
