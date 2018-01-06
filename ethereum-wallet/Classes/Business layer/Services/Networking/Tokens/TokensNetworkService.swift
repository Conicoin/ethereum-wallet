//
//  TokensNetworkService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation
import Alamofire

class TokensNetworkService: NetworkLoadable, TokensNetworkServiceProtocol {
  
  func getTokens(address address: String, result: @escaping (Result<[Token]>) -> Void) {
    loadArray(request: API.Ethplorer.tokens(address: address), keyPath: "tokens", completion: result)
  }

}
