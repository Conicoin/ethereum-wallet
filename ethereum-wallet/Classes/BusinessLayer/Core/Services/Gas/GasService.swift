// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Geth

class GasService: GasServiceProtocol {
  
  private let client: GethEthereumClient
  private let context: GethContext
  private let callMsgBuilder: GasCallMsgBuilder
  
  init(core: EthereumCoreProtocol, callMsgBuilder: GasCallMsgBuilder) {
    self.client = core.client
    self.context = core.context
    self.callMsgBuilder = callMsgBuilder
  }
  
  func getSuggestedGasLimit(from: String, to: String, amount: Decimal, settings: SendSettings, result: @escaping (Result<Decimal>) -> Void) {
    
    Ethereum.syncQueue.async { [unowned self] in
      do {
        let msg = try self.callMsgBuilder.build(from: from, to: to, amount: amount, settings: settings)
        
        var gasLimit: Int64 = 0
        try self.client.estimateGas(self.context, msg: msg, gas: &gasLimit)
        DispatchQueue.main.async {
          result(.success(Decimal(gasLimit)))
        }
      } catch {
        DispatchQueue.main.async {
          result(.failure(error))
        }
      }
    }
  }
  
  func getSuggestedGasPrice(result: @escaping (Result<Decimal>) -> Void) {
    Ethereum.syncQueue.async {
      do {
        let gasPrice = try self.client.suggestGasPrice(self.context)
        DispatchQueue.main.async {
          result(.success(Decimal(gasPrice.getString(10))))
        }
      } catch {
        DispatchQueue.main.async {
          result(.failure(error))
        }
      }
    }
  }

}
