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
      let callMsgBuilder = DefaultCallMsgBuilder()
      return GasService(core: core, callMsgBuilder: callMsgBuilder)
    case .token(let token):
      let inputBuilder = EthTokenTxInputBuilder(decimals: token.decimals)
      let callMsgBuilder = TokenCallMsgBuilder(inputBuilder: inputBuilder, contractAddress: token.address)
      return GasService(core: core, callMsgBuilder: callMsgBuilder)
    }
  }

}
