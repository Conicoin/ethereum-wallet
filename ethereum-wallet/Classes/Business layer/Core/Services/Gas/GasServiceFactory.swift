//
//  GasServiceFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 30/07/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class GasServiceFactory {
  
  let core: EthereumCoreProtocol
  
  init(core: EthereumCoreProtocol) {
    self.core = core
  }
  
  func create(_ type: TransferType) -> GasServiceProtocol {
    switch type {
    case .default:
      return GasService(core: core, inputBuilder: EthDefaultTxInputBuilder())
    case .token(let token):
      return GasService(core: core, inputBuilder: EthTokenTxInputBuilder(decimals: token.decimals))
    }
  }

}
