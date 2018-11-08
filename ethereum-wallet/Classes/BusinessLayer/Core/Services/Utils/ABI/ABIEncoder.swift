// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import CryptoSwift

/// Encodes fields according to Ethereum's Application Binary Interface Specification
///
/// - SeeAlso: https://solidity.readthedocs.io/en/develop/abi-spec.html
final class ABIEncoder {
  static let encodedIntSize = 32
  
  /// Encoded data
  var data = Data()
  
  /// Creates an `ABIEncoder`.
  init() {}
  
  /// Encodes an `ABIValue`
  func encode(_ value: ABIValue) throws {
    switch value {
    case .uint(_, let value):
      try encode(value)
    case .int(_, let value):
      try encode(value)
    case .address(let address):
      try encode(address)
    case .bool(let value):
      try encode(value)
    case .fixed(_, _, let value):
      try encode(value)
    case .ufixed(_, _, let value):
      try encode(value)
    case .bytes(let data):
      try encode(data, static: true)
    case .function(let f, let args):
      try encode(signature: f.description)
      try encode(tuple: args)
    case .array(let type, let array):
      precondition(!array.contains(where: { $0.type != type }), "Array can only contain values of type \(type)")
      try encode(tuple: array)
    case .dynamicBytes(let data):
      try encode(data, static: false)
    case .string(let string):
      try encode(string)
    case .dynamicArray(let type, let array):
      precondition(!array.contains(where: { $0.type != type }), "Array can only contain values of type \(type)")
      try encode(array.count)
      try encode(tuple: array)
    case .tuple(let array):
      try encode(tuple: array)
    }
  }
  
  /// Encodes a tuple
  func encode(tuple: [ABIValue]) throws {
    var headSize = 0
    for subvalue in tuple {
      if subvalue.isDynamic {
        headSize += 32
      } else {
        headSize += subvalue.length
      }
    }
    
    var dynamicOffset = 0
    for subvalue in tuple {
      if subvalue.isDynamic {
        try encode(headSize + dynamicOffset)
        dynamicOffset += subvalue.length
      } else {
        try encode(subvalue)
      }
    }
    
    for subvalue in tuple where subvalue.isDynamic {
      try encode(subvalue)
    }
  }
  
  /// Encodes a function call
  func encode(function: Function, arguments: [Any]) throws {
    try encode(signature: function.description)
    try encode(tuple: function.castArguments(arguments))
  }
  
  /// Encodes a boolean field.
  func encode(_ value: Bool) throws {
    data.append(Data(repeating: 0, count: ABIEncoder.encodedIntSize - 1))
    data.append(value ? 1 : 0)
  }
  
  /// Encodes an unsigned integer.
  func encode(_ value: UInt) throws {
    try encode(Decimal(value))
  }
  
  /// Encodes a `BigUInt` field.
  ///
  /// - Throws: `ABIError.integerOverflow` if the value has more than 256 bits.
  func encode(_ value: Decimal) throws {
    let valueData = value.serialize()
    if valueData.count > ABIEncoder.encodedIntSize {
      throw ABIError.integerOverflow
    }
    
    data.append(Data(repeating: 0, count: ABIEncoder.encodedIntSize - valueData.count))
    data.append(valueData)
  }
  
  /// Encodes a signed integer.
  func encode(_ value: Int) throws {
    try encode(Decimal(value))
  }
  
  /// Encodes a static or dynamic byte array
  func encode(_ bytes: Data, static: Bool) throws {
    if !`static` {
      try encode(bytes.count)
    }
    let count = min(32, bytes.count)
    let padding = ((count + 31) / 32) * 32 - count
    data.append(bytes[0..<count])
    data.append(Data(repeating: 0, count: padding))
  }
  
  /// Encodes an address
  func encode(_ address: Address) throws {
    let padding = ((address.data.count + 31) / 32) * 32 - address.data.count
    data.append(Data(repeating: 0, count: padding))
    data.append(address.data)
  }
  
  /// Encodes a string
  ///
  /// - Throws: `ABIError.invalidUTF8String` if the string cannot be encoded as UTF8.
  func encode(_ string: String) throws {
    guard let bytes = string.data(using: .utf8) else {
      throw ABIError.invalidUTF8String
    }
    try encode(bytes, static: false)
  }
  
  /// Encodes a function signature
  func encode(signature: String) throws {
    data.append(try ABIEncoder.encode(signature: signature))
  }
  
  /// Encodes a function signature
  static func encode(signature: String) throws -> Data {
    guard let bytes = signature.data(using: .utf8) else {
      throw ABIError.invalidUTF8String
    }
    let hash = SHA3(variant: .keccak256).calculate(for: bytes.bytes)
    return Data(hash[0..<4])
  }
}
