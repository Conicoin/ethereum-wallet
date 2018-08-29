// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class TokensNetworkService: NetworkLoadable, TokensNetworkServiceProtocol {
  
  func getTokens(address: String, queue: DispatchQueue, result: @escaping (Result<[Token]>) -> Void) {
    loadArray(request: API.Token.tokens(address: address), keyPath: "docs", queue: queue, completion: result)
  }

}
