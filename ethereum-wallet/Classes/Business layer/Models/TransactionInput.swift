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

struct TransactionInput {
  
  let raw: Data
  let address: String
  let amount: Decimal
  
  init?(input: Data) {
    guard input.starts(with: [0x0, 0xa9, 0x05, 0x9c, 0xbb]) else {
      return nil
    }
    let addressData = input[input.count-32-20..<input.count-32]
    let amountData = input[input.count-32..<input.count]
    self.address = "0x" + addressData.toHexString()
    self.amount = Decimal(hexString: amountData.toHexString())
    self.raw = input
  }
  
}
