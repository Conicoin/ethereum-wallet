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


import UIKit

struct TokenValue: Currency {
  
  let raw: Decimal
  let value: Double
  let name: String
  let iso: String
  
  init(_ value: Decimal, name: String, iso: String) {
    self.raw = value
    self.value = value.double / 1e18
    self.name = name
    self.iso = iso
  }
  
  init(_ string: String, name: String, iso: String) {
    let number = Decimal(string)
    self.init(number, name: name, iso: iso)
  }
  
  var symbol: String {
    return iso
  }
  
}
