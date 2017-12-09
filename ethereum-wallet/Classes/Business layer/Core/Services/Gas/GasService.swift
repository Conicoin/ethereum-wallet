// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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
import Alamofire

class GasService: GasServiceProtocol {
  
  private let client: GethEthereumClient
  private let context: GethContext
  
  init(core: Ethereum) {
    self.client = core.client
    self.context = core.context
  }
  
  func getSuggestedGasLimit(result: @escaping (Result<Int64>) -> Void) {
    Ethereum.syncQueue.async {
      do {
        let msg = GethNewCallMsg()
        let gasLimit = try self.client.estimateGas(self.context, msg: msg)
        DispatchQueue.main.async {
          result(.success(gasLimit.getInt64()))
        }
      } catch {
        DispatchQueue.main.async {
          result(.failure(error))
        }
      }
    }
  }
  
  func getSuggestedGasPrice(result: @escaping (Result<Int64>) -> Void) {
    Ethereum.syncQueue.async {
      do {
        let gasPrice = try self.client.suggestGasPrice(self.context)
        DispatchQueue.main.async {
          result(.success(gasPrice.getInt64()))
        }
      } catch {
        DispatchQueue.main.async {
          result(.failure(error))
        }
      }
    }
  }

}
