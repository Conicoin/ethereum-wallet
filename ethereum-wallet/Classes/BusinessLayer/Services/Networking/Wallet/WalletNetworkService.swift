// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

class WalletNetworkService: NetworkLoadable, WalletNetworkServiceProtocol {

  func getBalance(address: String, queue: DispatchQueue, result: @escaping (Result<String>) -> Void) {
    loadObjectJSON(request: API.Etherscan.balance(address: address), queue: queue) { resultHandler in
      
      switch resultHandler {
      case .success(let object):
        
        guard let json = object as? [String: Any], let balance = json["result"] as? String else {
          result(Result.failure(NetworkError.parseError))
          return
        }
        
        result(Result.success(balance))
        
      case .failure(let error):
        result(Result.failure(error))
      }
      
    }
  }
  
}
