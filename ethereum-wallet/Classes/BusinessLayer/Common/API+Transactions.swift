// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Alamofire

extension API {
  
  enum Transactions {
    case transactions(address: String, page: Int, limit: Int)
  }
  
}

extension API.Transactions: APIMethodProtocol {
  
  var path: String {
    switch self {
    case .transactions:
      let chain = Defaults.chain
      return chain.backend + "/transactions"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .transactions:
      return .get
    }
  }
  
  var params: APIMethodProtocol.Params? {
    switch self {
    case .transactions(let address, let page, let limit):
      return [
        "address": address,
        "limit": limit,
        "page": page
      ]
    }
  }
  
}
