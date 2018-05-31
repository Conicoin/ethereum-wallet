//
//  API+Push.swift
//  ethereum-wallet
//
//  Created by Nikita Medvedev on 01/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Alamofire

extension API {
  
  enum Push {
    case register(token: String, address: String)
    case unregister
  }
  
}

extension API.Push: APIMethodProtocol {
  
  var method: HTTPMethod {
    return .post
  }
  
  var path: String {
    let backendURL = "http://18.217.141.154:8000"
    var method = ""
    
    switch self {
    case .register:
      method = "/push/register"
    case .unregister:
      method = "/push/unregister"
    }
    
    return "\(backendURL)\(method)"
  }
  
  var params: Params? {
    switch self {
    case .register(let token, let address):
      return [
        "wallets": [address],
        "deviceID": UUID().uuidString.lowercased(),
        "token": token
      ]
    case .unregister:
      return [
        "deviceID": UUID().uuidString.lowercased()
      ]
    }
  }
  
}
