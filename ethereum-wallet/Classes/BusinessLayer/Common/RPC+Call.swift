// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


extension RPC {
  
  struct Call: RPCMethod {
    
    typealias Response = String
    
    let from: String?
    let to: String
    let gasLimit: Decimal?
    let gasPrice: Decimal?
    let value: Decimal?
    let data: String?
    let blockParameter: BlockParameter
    
    var method: String {
      return "eth_call"
    }
    
    var parameters: Any? {
      return [
        [ "from": from,
          "to": to,
          "gas": gasLimit?.string,
          "gasPrice": gasPrice?.string,
          "value": value?.string,
          "data": data].safe(),
        blockParameter.rawValue
      ]
    }
    
    func response(from resultObject: Any) throws -> Response {
      guard let response = resultObject as? Response else {
        throw JSONRPCError.unexpectedTypeObject(resultObject)
      }
      return response
    }
  }
  
}
