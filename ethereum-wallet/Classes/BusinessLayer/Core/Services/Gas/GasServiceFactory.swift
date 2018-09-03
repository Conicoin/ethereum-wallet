// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
