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


import UIKit

struct Constants {
  
  struct Ethereum {
    static let rinkebyEnodeRawUrl = "enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303?discport=30304"
    static let ropstenEnodeRawUrl = "enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303?discport=30304"
  }
  
  struct Etherscan {
    static let apiKey = "1KDW41TE2CPJI7DC2UWSXUWRQ6WFUR885E"
  }
  
  struct Wallet {
    static let defaultCurrency = "USD"
    static let supportedCurrencies = ["BTC","ETH","USD","EUR","CNY","GBP"]
  }
  
  struct Send {
    static let defaultGasLimit: Decimal = 21000
    static let defaultGasLimitToken: Decimal = 53000
    static let defaultGasPrice: Decimal = 2000000000
    static let maxGasLimit: Decimal = 1000000
    static let maxGasPrice: Decimal = 50000000000
    static let minGasLimit: Decimal = 21000
    static let minGasPrice: Decimal = 1000000000
  }
  
}
