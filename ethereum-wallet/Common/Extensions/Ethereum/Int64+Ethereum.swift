//
//  Int64+Ethereum.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 25/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

extension Int64 {
  
  func toEtherString() -> String {
    return "\(String(self / 1000000000000000000)) Ether"
  }

}
