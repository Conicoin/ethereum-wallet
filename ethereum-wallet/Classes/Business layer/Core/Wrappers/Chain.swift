// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



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
//      return "http://18.222.83.172:8000"
      return "https://api.trustwalletapp.com"
    case .ropsten:
      fatalError("Not supported yet")
    case .rinkeby:
//      return "http://18.216.110.94:8000"
      return "https://rinkeby.trustwalletapp.com"
    }
  }
  
  var privateKeyPrefix: UInt32 {
    let mainnetPrefix: UInt32 = 0x0488ade4
    let testnetPrefix: UInt32 = 0x04358394
    
    switch self {
    case .mainnet:
      return mainnetPrefix
    case .ropsten, .rinkeby:
      return testnetPrefix
    }
  }
  
  var publicKeyPrefix: UInt32 {
    let mainnetPrefix: UInt32 = 0x0488b21e
    let testnetPrefix: UInt32 = 0x043587cf
    
    switch self {
    case .mainnet:
      return mainnetPrefix
    case .ropsten, .rinkeby:
      return testnetPrefix
    }
  }
  
  var bip44CoinType: UInt32 {
    let mainnetCoinType = UInt32(60)
    let testnetCoinType = UInt32(1)
    
    switch self {
    case .mainnet:
      return mainnetCoinType
    case .ropsten, .rinkeby:
      return testnetCoinType
    }
  }
  
  var isMainnet: Bool {
    return self == .mainnet
  }
  
  static func all() -> [Chain] {
    return [.mainnet, .ropsten, .rinkeby]
  }
  
}
