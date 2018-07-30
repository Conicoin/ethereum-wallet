//
//  PushNetworkingService.swift
//  ethereum-wallet
//
//  Created by Nikita Medvedev on 01/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class PushNetworkService: NetworkLoadable, PushNetworkServiceProtocol  {
  
  func register(token: String, address: String, queue: DispatchQueue, result: @escaping (Result<Bool>) -> Void) {
    loadObjectJSON(request: API.Push.register(token: token, address: address), queue: queue) { resultHandler in
      switch resultHandler {
        
      case .success(let object):
        print(object)
        // TODO: check if device is registered
        result(Result.success(true))
        
      case .failure(let error):
        result(Result.failure(error))
      }

    }
  }
  
  func unregister(queue: DispatchQueue, result: @escaping (Result<Bool>) -> Void) {
    loadObjectJSON(request: API.Push.unregister, queue: queue) { resultHandler in
      
    }
  }
  
}

