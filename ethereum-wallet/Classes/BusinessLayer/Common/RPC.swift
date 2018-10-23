//
//  RPC.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 08/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import Alamofire
import JSONRPCKit


protocol RPCMethod: JSONRPCKit.Request, APIMethodProtocol {
  
}

extension RPCMethod {
  
  var path: String {
    return Defaults.chain.clientUrl
  }
  
  var method: HTTPMethod {
    return .post
  }
  
  var params: Params? {
    let batch = BatchElement(request: self, version: "2.0", id: .number(1))
    return batch.body as? [String: Any]
  }
  
}

enum RPC { }
