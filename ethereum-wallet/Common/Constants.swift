//
//  Constants.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 27/04/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Ethereum {
        static let enodeRawUrl = "enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303?discport=30304"
        static let appSecret = "688e2b77-09a3-4945-9468-bf188ff3de88"
    }
    
    struct Keychain {
        static let serviceName = "ethereum-wallet"
        static let jsonKey = "json_key_data"
    }

}
