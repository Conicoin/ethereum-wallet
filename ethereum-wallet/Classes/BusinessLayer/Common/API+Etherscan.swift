// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Alamofire

extension API {
  
  enum Etherscan {
    case transactions(address: String)
    case balance(address: String)
    case tokenBalance(address: String, contractAddress: String)
  }
  
}

extension API.Etherscan: APIMethodProtocol {
  
  var method: HTTPMethod {
      return .get
  }
  
  var path: String {
    let chain = Defaults.chain
    return "https://\(chain.etherscanApiUrl)/api?"
  }
  
  var params: Params? {
    switch self {
    case .transactions(let address):
      return [
        "module": "account",
        "action": "txlist",
        "address": address,
        "startblock": 0,
        "endblock": 99999999,
        "sort": "asc",
        "apiKey": Constants.Etherscan.apiKey
      ]
    case .balance(let address):
      return [
        "module": "account",
        "action": "balance",
        "address": address,
        "tag": "latest",
        "apiKey": Constants.Etherscan.apiKey
      ]
    case .tokenBalance(let address, let contractAddress):
        return [
          "module": "account",
          "action": "tokenbalance",
          "contractaddress": contractAddress,
          "address": address,
          "tag": "latest",
          "apikey": Constants.Etherscan.apiKey
        ]
    }
  }
  
}
