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

struct Ether {
  
  let raw: Decimal
  let value: Double

  init(_ value: Decimal) {
    self.raw = value * 1e18
    self.value = value.double
  }
  
  init(weiValue: Decimal) {
    self.raw = weiValue
    self.value = weiValue.double / 1e18
  }
  
  init(_ double: Double) {
    self.raw = Decimal(double) * 1e18
    self.value = double
  }
  
  init(_ string: String) {
    let number = Decimal(string)
    self.init(number)
  }
  
  init(weiString: String) {
    let number = Decimal(weiString)
    self.init(weiValue: number)
  }

}

extension Ether: Currency {
  
  var name: String {
    return "Ethereum"
  }
  
  var iso: String {
    return "ETH"
  }
  
  var symbol: String {
    return "Ξ"
  }

}
