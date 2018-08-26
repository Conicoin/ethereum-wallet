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

extension Data {
  
  init<T>(from value: T) {
    var value = value
    self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
  }
  
  func to<T>(type: T.Type) -> T {
    return self.withUnsafeBytes { $0.pointee }
  }
  
}

protocol DataConvertable {
  static func +(lhs: Data, rhs: Self) -> Data
  static func +=(lhs: inout Data, rhs: Self)
}

extension DataConvertable {
  static func +(lhs: Data, rhs: Self) -> Data {
    var value = rhs
    let data = Data(buffer: UnsafeBufferPointer(start: &value, count: 1))
    return lhs + data
  }
  
  static func +=(lhs: inout Data, rhs: Self) {
    lhs = lhs + rhs
  }
}

extension UInt8: DataConvertable {}
extension UInt32: DataConvertable {}
