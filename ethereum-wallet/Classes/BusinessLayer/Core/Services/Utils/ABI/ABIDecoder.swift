//
//  ABIDecoder.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class ABIDecoder {
  let data: Data
  var offset = 0
  
  init(data: Data) {
    self.data = data
  }
  
  func decode(type: ABIType) throws -> ABIValue {
    switch type {
    case .uint(let bits):
      return .uint(bits: bits, decodeUInt())
    case .int(let bits):
      return .int(bits: bits, decodeInt())
    case .address:
      return .address(decodeAddress())
    case .bool:
      return .bool(decodeBool())
    case .fixed(let bits, let scale):
      return .fixed(bits: bits, scale, decodeInt())
    case .ufixed(let bits, let scale):
      return .ufixed(bits: bits, scale, decodeUInt())
    case .bytes(let count):
      return .bytes(decodeBytes(count: count))
    case .function(let f):
      return try decode(function: f)
    case .array(let type, let count):
      return .array(type, try decodeArray(type: type, count: count))
    case .dynamicBytes:
      return .dynamicBytes(decodeBytes())
    case .string:
      return .string(try decodeString())
    case .dynamicArray(let type):
      return .dynamicArray(type, try decodeArray(type: type))
    case .tuple(let types):
      return .tuple(try decodeTuple(types: types))
    }
  }
  
  /// Decodes a dynamic array
  func decodeArray(type: ABIType) throws -> [ABIValue] {
    _ = decodeUInt()
    let count = decodeUInt().int
    return try decodeArray(type: type, count: count)
  }
  
  /// Decodes a static array
  func decodeArray(type: ABIType, count: Int) throws -> [ABIValue] {
    return try decodeTuple(types: Array(repeating: type, count: count))
  }
  
  /// Decodes a tuple
  func decodeTuple(types: [ABIType]) throws -> [ABIValue] {
    let baseOffset = offset
    
    var values = [ABIValue]()
    for subtype in types {
      let value: ABIValue
      if subtype.isDynamic {
        let count = decodeUInt().int
        let savedOffset = offset
        offset = baseOffset + count
        value = try decode(type: subtype)
        offset = savedOffset
      } else {
        value = try decode(type: subtype)
      }
      values.append(value)
    }
    return values
  }
  
  /// Decodes a function call
  ///
  /// - Throws: `ABIError.functionSignatureMismatch` if the decoded signature hash doesn't match the specified function.
  func decode(function: Function) throws -> ABIValue {
    if try ABIEncoder.encode(signature: function.description) != decodeSignature() {
      throw ABIError.functionSignatureMismatch
    }
    let arguments = try decodeTuple(types: function.parameters)
    return .function(function, arguments)
  }
  
  /// Decodes a boolean field.
  func decodeBool() -> Bool {
    return decodeUInt() != Decimal(0)
  }
  
  /// Decodes an unsigned integer.
  func decodeUInt() -> Decimal {
    assert(offset + ABIEncoder.encodedIntSize <= data.count)
    let value = Decimal(data: data.subdata(in: offset ..< offset + ABIEncoder.encodedIntSize))
    offset += ABIEncoder.encodedIntSize
    return value
  }
  
  /// Decodes a `BigInt` field.
  func decodeInt() -> Decimal {
    let unsigned = decodeUInt()
    if unsigned._isNegative == 0 {
      return unsigned
    }
    
    let max = Decimal(1 << (ABIEncoder.encodedIntSize * 8))
    let num = unsigned
    return -(max - num)
  }
  
  /// Decodes a dynamic byte array
  func decodeBytes() -> Data {
    return decodeBytes(count: decodeUInt().int)
  }
  
  /// Decodes a static byte array
  func decodeBytes(count: Int) -> Data {
    let value = data.subdata(in: offset ..< offset + count)
    offset += count
    return value
  }
  
  /// Decodes an address
  func decodeAddress() -> Address {
    let addressLength = 20
    let range = offset + ABIEncoder.encodedIntSize - addressLength ..< offset + ABIEncoder.encodedIntSize
    let address = try! Address(data: data.subdata(in: range))
    offset += ABIEncoder.encodedIntSize
    return address
  }
  
  /// Decodes a string
  ///
  /// - Throws: `ABIError.invalidUTF8String` if the string cannot be decoded as UTF8.
  func decodeString() throws -> String {
    let count = decodeUInt().int
    guard let string = String(data: data.subdata(in: offset ..< offset + count), encoding: .utf8) else {
      throw ABIError.invalidUTF8String
    }
    offset += count
    return string
  }
  
  /// Decodes a function signature
  func decodeSignature() -> Data {
    let value = data.subdata(in: offset ..< offset + 4)
    offset += 4
    return value
  }
}

