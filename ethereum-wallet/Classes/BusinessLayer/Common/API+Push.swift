// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
    switch self {
    case .register:
      return Defaults.chain.pushBackend + "/push/register"
    case .unregister:
      return Defaults.chain.pushBackend + "/push/unregister"
    }
  }
  
  var params: Params? {
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    switch self {
    case .register(let token, let address):
      return [
        "wallets": [address],
        "deviceID": deviceId.lowercased(),
        "token": token
      ]
    case .unregister:
      return [
        "deviceID": deviceId.lowercased()
      ]
    }
  }
  
}
