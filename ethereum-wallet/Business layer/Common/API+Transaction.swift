//
//  API+TransactionList.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import Alamofire

extension API {
    
    enum Transaction {
        case list(address: String)
    }

}

extension API.Transaction: APIMethodProtocol {
    
    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        }
    }
    
    var params: Params? {
        switch self {
        case .list(let address):
            return [
                "module": "account",
                "action": "txlist",
                "address": address,
                "startblock": 0,
                "endblock": 99999999,
                "sort": "asc"   
            ]
        }
    }
    
}
