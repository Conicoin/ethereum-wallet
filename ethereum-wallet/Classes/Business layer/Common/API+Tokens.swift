//
//  API+Tokens.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 14/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Alamofire

extension API {
    
    enum Token {
        case tokens(address: String)
    }
    
}

extension API.Token: APIMethodProtocol {
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .tokens:
            return Defaults.chain.backend + "/tokens"
        }
    }
    
    var params: Params? {
        switch self {
        case .tokens(let address):
            return ["address": address]
        }
    }
    
}
