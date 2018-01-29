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


import Alamofire

extension API {
  
  enum Etherscan {
    case transactions(address: String)
    case balance(address: String)
  }
  
}

extension API.Etherscan: APIMethodProtocol {
  
  var method: HTTPMethod {
      return .get
  }
  
  var path: String {
    let chain = Defaults.chain
    return "https://\(chain.etherscanApiUrl)/api?"
  }
  
  var params: Params? {
    switch self {
    case .transactions(let address):
      return [
        "module": "account",
        "action": "txlist",
        "address": address,
        "startblock": 0,
        "endblock": 99999999,
        "sort": "asc",
        "apiKey": Constants.Etherscan.apiKey
      ]
    case .balance(let address):
      return [
        "module": "account",
        "action": "balance",
        "address": address,
        "tag": "latest",
        "apiKey": Constants.Etherscan.apiKey
      ]
    }
  }
  
}
