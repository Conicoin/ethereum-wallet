//
//  Address.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct Address {
    
    let string: String
    
    init(string: String) {
        self.string = string
    }
    
    init(data: Data) {
        self.string = "0x" + data.hex()
    }

}
