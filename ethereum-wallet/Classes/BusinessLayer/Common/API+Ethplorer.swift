// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Alamofire

extension API {
  
  enum Ethplorer {
    case tokens(address: String)
    case transactions(address: String)
    case tokenTransactions(address: String)
  }
  
}

extension API.Ethplorer: APIMethodProtocol {
  
  var path: String {
    switch self {
    case .tokens(let address):
      return "https://api.ethplorer.io/getAddressInfo/\(address)"
    case .transactions(let address):
      return "https://api.ethplorer.io/getAddressTransactions/\(address)"
    case .tokenTransactions(let address):
      return "https://api.ethplorer.io/getAddressHistory/\(address)"
    }
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var params: APIMethodProtocol.Params? {
    return [
      "apiKey": "freekey"
    ]
  }
  
}
