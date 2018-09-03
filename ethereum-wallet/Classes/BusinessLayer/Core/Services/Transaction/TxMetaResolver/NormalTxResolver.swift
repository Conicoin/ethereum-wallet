// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class NormalTxResolver: TxMetaResolver {
  
  var nextResolver: TxMetaResolver?
  
  func resolve(_ input: Data) -> TxType {
    guard input != Data([0x0]) else {
      return .normal
    }
    return nextResolver(for: input)
  }
  
  @discardableResult
  func chain(_ next: TxMetaResolver) -> TxMetaResolver {
    self.nextResolver = next
    return next
  }

}
