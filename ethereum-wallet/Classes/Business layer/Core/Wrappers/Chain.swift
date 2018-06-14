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

enum Chain: String {
  
  case mainnet
  case ropsten
  case rinkeby
  
  static var `default`: Chain {
    return .mainnet
  }
  
  var chainId: Int64 {
    switch self {
    case .mainnet:
      return 1
    case .ropsten:
      return 3
    case .rinkeby:
      return 4
    }
  }
  
  var netStats: String? {
    switch self {
    case .rinkeby:
      return "flypaper:Respect my authoritah!@stats.rinkeby.io"
    default:
      return nil
    }
  }
  
  var enode: String? {
    switch self {
    case .mainnet:
      return nil
    case .ropsten:
      return Constants.Ethereum.ropstenEnodeRawUrl
    case .rinkeby:
      return Constants.Ethereum.rinkebyEnodeRawUrl
    }
  }
  
  var genesis: String {
    switch self {
    case .mainnet:
      return GethMainnetGenesis()
    case .ropsten:
      return GethTestnetGenesis()
    case .rinkeby:
      return GethRinkebyGenesis()
    }
  }
  
  var description: String {
    return "\(self)"
  }
  
  var localizedDescription: String {
    switch self {
    case .mainnet:
      return "Mainnet"
    case .ropsten:
      return "Ropsten Testnet"
    case .rinkeby:
      return "Rinkeby Testnet"
    }
  }
  
  var path: String {
    return "/.\(description)"
  }
  
  var etherscanApiUrl: String {
    switch self {
    case .mainnet:
      return "api.etherscan.io"
    case .ropsten:
      return "ropsten.etherscan.io"
    case .rinkeby:
      return "rinkeby.etherscan.io"
    }
  }
  
  var clientUrl: String {
    switch self {
    case .mainnet:
      return "https://mainnet.infura.io"
    case .ropsten:
      return "https://ropsten.infura.io"
    case .rinkeby:
      return "https://rinkeby.infura.io"
    }
  }
  
  var etherscanUrl: String {
    switch self {
    case .mainnet:
      return "https://etherscan.io"
    case .ropsten:
      return "https://ropsten.etherscan.io"
    case .rinkeby:
      return "https://rinkeby.etherscan.io"
    }
  }
  
  var backend: String {
    switch self {
    case .mainnet:
      return "http://18.222.83.172:8000"
    case .ropsten:
      fatalError("Not supported yet")
    case .rinkeby:
      return "http://18.216.110.94:8000"
    }
  }
  
  var isMainnet: Bool {
    return self == .mainnet
  }
  
  static func all() -> [Chain] {
    return [.mainnet, .ropsten, .rinkeby]
  }
  
}
