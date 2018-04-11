//
//  NormalTxResolver.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class NormalTxResolver: TxMetaResolver {
  
  var nextResolver: TxMetaResolver?
  
  func resolve(_ input: Data) -> TxType {
    guard input != Data([0x0]) else {
      return .normal
    }
    return nextResolver(for: input)
  }
  
  func chain(_ next: TxMetaResolver) -> TxMetaResolver {
    self.nextResolver = next
    return next
  }

}
