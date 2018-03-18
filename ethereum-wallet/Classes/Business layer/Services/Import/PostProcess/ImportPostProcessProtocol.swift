//
//  ImportPostProcessProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Alamofire

protocol ImportPostProcessProtocol {
    func verifyKey(_ key: String, completion: (Result<Data>) -> Void)
}
