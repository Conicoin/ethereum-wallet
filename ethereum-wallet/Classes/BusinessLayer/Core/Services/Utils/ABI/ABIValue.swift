//
//  ABIValue.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

indirect enum ABIValue: Equatable {
  /// Unsigned integer with `0 < bits <= 256`, `bits % 8 == 0`
  case uint(bits: Int, Decimal)
  
  /// Signed integer with `0 < bits <= 256`, `bits % 8 == 0`
  case int(bits: Int, Decimal)
  
  /// Address, similar to `uint(bits: 160)`
  case address(Address)
  
  /// Boolean
  case bool(Bool)
  
  /// Signed fixed-point decimal number of M bits, `8 <= M <= 256`, `M % 8 == 0`, and `0 < N <= 80`, which denotes the value `v` as `v / (10 ** N)`
  case fixed(bits: Int, Int, Decimal)
  
  /// Unsigned fixed-point decimal number of M bits, `8 <= M <= 256`, `M % 8 == 0`, and `0 < N <= 80`, which denotes the value `v` as `v / (10 ** N)`
  case ufixed(bits: Int, Int, Decimal)
  
  /// Fixed-length bytes
  case bytes(Data)
  
  /// A function call
  case function(Function, [ABIValue])
  
  /// Fixed-length array where all values have the same type
  case array(ABIType, [ABIValue])
  
  /// Dynamic-sized byte sequence
  case dynamicBytes(Data)
  
  /// String
  case string(String)
  
  /// Variable-length array where all values have the same type
  case dynamicArray(ABIType, [ABIValue])
  
  /// Tuple
  case tuple([ABIValue])
  
  /// Value type
  var type: ABIType {
    switch self {
    case .uint(let bits, _):
      return .uint(bits: bits)
    case .int(let bits, _):
      return .int(bits: bits)
    case .address:
      return .address
    case .bool:
      return .bool
    case .fixed(let bits, let scale, _):
      return .fixed(bits, scale)
    case .ufixed(let bits, let scale, _):
      return .ufixed(bits, scale)
    case .bytes(let data):
      return .bytes(data.count)
    case .function(let f, _):
      return .function(f)
    case .array(let type, let array):
      return .array(type, array.count)
    case .dynamicBytes:
      return .dynamicBytes
    case .string:
      return .string
    case .dynamicArray(let type, _):
      return .dynamicArray(type)
    case .tuple(let array):
      return .tuple(array.map({ $0.type }))
    }
  }
  
  /// Encoded length in bytes
  var length: Int {
    switch self {
    case .uint, .int, .address, .bool, .fixed, .ufixed:
      return 32
    case .bytes(let data):
      return ((data.count + 31) / 32) * 32
    case .function(_, let args):
      return 4 + args.reduce(0, { $0 + $1.length })
    case .array(_, let array):
      return array.reduce(0, { $0 + $1.length })
    case .dynamicBytes(let data):
      return 32 + ((data.count + 31) / 32) * 32
    case .string(let string):
      let dataLength = string.data(using: .utf8)?.count ?? 0
      return 32 + ((dataLength + 31) / 32) * 32
    case .dynamicArray(_, let array):
      return 32 + array.reduce(0, { $0 + $1.length })
    case .tuple(let array):
      return array.reduce(0, { $0 + $1.length })
    }
  }
  
  /// Whether the value is dynamic
  var isDynamic: Bool {
    switch self {
    case .uint, .int, .address, .bool, .fixed, .ufixed, .bytes, .array:
      return false
    case .dynamicBytes, .string, .dynamicArray:
      return true
    case .function(_, let array):
      return array.contains(where: { $0.isDynamic })
    case .tuple(let array):
      return array.contains(where: { $0.isDynamic })
    }
  }
  
  /// Creates a value from `Any` and an `ABIType`.
  ///
  /// - Throws: `ABIError.invalidArgumentType` if a value doesn't match the expected type.
  init(_ value: Any, type: ABIType) throws {
    switch (type, value) {
    case (.uint(let bits), let value as Int):
      self = .uint(bits: bits, Decimal(value))
    case (.uint(let bits), let value as UInt):
      self = .uint(bits: bits, Decimal(value))
    case (.uint(let bits), let value as Decimal):
      self = .uint(bits: bits, value)
    case (.int(let bits), let value as Int):
      self = .int(bits: bits, Decimal(value))
    case (.int(let bits), let value as Decimal):
      self = .int(bits: bits, value)
    case (.address, let address as Address):
      self = .address(address)
    case (.bool, let value as Bool):
      self = .bool(value)
    case (.fixed(let bits, let scale), let value as Decimal):
      self = .fixed(bits: bits, scale, value)
    case (.ufixed(let bits, let scale), let value as Decimal):
      self = .ufixed(bits: bits, scale, value)
    case (.bytes(let size), let data as Data):
      if data.count > size {
        self = .bytes(data[..<size])
      } else {
        self = .bytes(data)
      }
    case (.function(let f), let args as [Any]):
      self = .function(f, try f.castArguments(args))
    case (.array(let type, _), let array as [Any]):
      self = .array(type, try array.map({ try ABIValue($0, type: type) }))
    case (.dynamicBytes, let data as Data):
      self = .dynamicBytes(data)
    case (.dynamicBytes, let string as String):
      self = .dynamicBytes(string.data(using: .utf8) ?? Data(bytes: Array(string.utf8)))
    case (.string, let string as String):
      self = .string(string)
    case (.dynamicArray(let type), let array as [Any]):
      self = .dynamicArray(type, try array.map({ try ABIValue($0, type: type) }))
    case (.tuple(let types), let array as [Any]):
      self = .tuple(try zip(types, array).map({ try ABIValue($1, type: $0) }))
    default:
      throw ABIError.invalidArgumentType
    }
  }
  
  /// Returns the native (Swift) value for this ABI value.
  var nativeValue: Any {
    switch self {
    case .uint(_, let value):
      return value
    case .int(_, let value):
      return value
    case .address(let value):
      return value
    case .bool(let value):
      return value
    case .fixed(_, _, let value):
      return value
    case .ufixed(_, _, let value):
      return value
    case .bytes(let value):
      return value
    case .function(let f, let args):
      return (f, args)
    case .array(_, let array):
      return array.map({ $0.nativeValue })
    case .dynamicBytes(let value):
      return value
    case .string(let value):
      return value
    case .dynamicArray(_, let array):
      return array.map({ $0.nativeValue })
    case .tuple(let array):
      return array.map({ $0.nativeValue })
    }
  }
}
