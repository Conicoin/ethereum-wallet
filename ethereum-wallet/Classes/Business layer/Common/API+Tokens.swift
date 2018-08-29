// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
