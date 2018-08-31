// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class TxMetaChain {

  func resolve(input: Data) -> TxType {
    let normal = NormalTxResolver()
    let erc20 = Erc20TxResolver()
    normal.chain(erc20)
    return normal.resolve(input)
  }

}
