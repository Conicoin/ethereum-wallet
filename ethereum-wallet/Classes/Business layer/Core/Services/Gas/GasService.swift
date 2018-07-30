// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import Geth

class GasService: GasServiceProtocol {
  
  private let client: GethEthereumClient
  private let context: GethContext
  private let inputBuilder: EthTxInputBuilderProtocol
  
  init(core: EthereumCoreProtocol, inputBuilder: EthTxInputBuilderProtocol) {
    self.client = core.client
    self.context = core.context
    self.inputBuilder = inputBuilder
  }
  
  func getSuggestedGasLimit(from: String, to: String, gasPrice: Decimal, amount: Decimal, result: @escaping (Result<Decimal>) -> Void) {
    Ethereum.syncQueue.async { [unowned self] in
      do {
        let msg = GethNewCallMsg()!
        let toAddress = GethAddress(fromHex: to)
        msg.setTo(toAddress)
       
        let fromAddress = GethAddress(fromHex: from)
        msg.setFrom(fromAddress)
        
        let bigInt = GethNewBigInt(0)!
        let weiAmount = amount * 1e18
        bigInt.setString(weiAmount.toHex(), base: 16)
        msg.setValue(bigInt)
        
        let data = try self.inputBuilder.createInput(amount: amount, receiverAddress: to)
        msg.setData(data)
        
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
