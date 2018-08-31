// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Alamofire

extension API {
  
  enum Rate {
    case rate(currencies: [String])
  }
  
}

extension API.Rate: APIMethodProtocol {
  
  var path: String {
    return "https://min-api.cryptocompare.com/data/pricemulti?"
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var params: Params? {
    switch self {
    case .rate(let currencies):
      return [
        "fsyms": currencies.joined(separator: ","),
        "tsyms": Constants.Wallet.supportedCurrencies.joined(separator: ",")
      ]
    }
  }
  
}
