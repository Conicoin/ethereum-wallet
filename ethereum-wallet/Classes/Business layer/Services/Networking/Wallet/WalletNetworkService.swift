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


import Foundation
import Alamofire

class WalletNetworkService: NetworkLoadable, WalletNetworkServiceProtocol {

  func getBalance(address: String, queue: DispatchQueue, result: @escaping (Result<String>) -> Void) {
    loadObjectJSON(request: API.Etherscan.balance(address: address), queue: queue) { resultHandler in
      
      switch resultHandler {
      case .success(let object):
        
        guard let json = object as? [String: Any], let balance = json["result"] as? String else {
          result(Result.failure(NetworkError.parseError))
          return
        }
        
        result(Result.success(balance))
        
      case .failure(let error):
        result(Result.failure(error))
      }
      
    }
  }
  
}
