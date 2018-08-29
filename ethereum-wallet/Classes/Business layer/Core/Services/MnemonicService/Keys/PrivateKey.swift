// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
