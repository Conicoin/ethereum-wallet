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

struct TokenValue: Currency {
  
  let raw: Decimal
  let value: Double
  let name: String
  let iso: String
  let decimals: Int
  
  init(wei value: Decimal, name: String, iso: String, decimals: Int) {
    self.raw = value
    self.value = value.double / pow(10, Double(decimals))
    self.name = name
    self.iso = iso
    self.decimals = decimals
  }
  
  init(_ value: Decimal, name: String, iso: String, decimals: Int) {
    self.raw = value * Decimal(pow(10, Double(decimals)))
    self.value = value.double
    self.name = name
    self.iso = iso
    self.decimals = decimals
  }
  
  var symbol: String {
    return iso
  }
  
}
