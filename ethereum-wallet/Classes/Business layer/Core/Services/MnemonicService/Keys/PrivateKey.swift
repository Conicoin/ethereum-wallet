//
//  PrivateKey.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct PrivateKey {
  
  let raw: Data
  
  init(raw: Data) {
    self.raw = raw
  }
  
  var publicKey: PublicKey {
    return PublicKey(privateKey: self)
  }

}
