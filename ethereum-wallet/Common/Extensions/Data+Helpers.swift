// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
