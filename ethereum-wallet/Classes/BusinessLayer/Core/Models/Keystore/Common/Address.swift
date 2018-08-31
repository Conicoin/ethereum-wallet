// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
