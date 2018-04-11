//
//  TxMetaChain.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/04/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class TxMetaChain {

  func resolve(input: Data) -> TxType {
    let normal = NormalTxResolver()
    let erc20 = Erc20TxResolver()
    normal.chain(erc20)
    return normal.resolve(input)
  }

}
