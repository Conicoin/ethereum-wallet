// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


enum RLPEncodableError: Error, CustomStringConvertible {
  case incompatibleType(elementType: Any)
  case negativeNumber(element: Any)
  
  public var description: String {
    switch self {
    case let .incompatibleType(elementType: elementType):
      let t = type(of: elementType)
      return "RLPEncodableError: Incompatible type \(t)"
      
    case let .negativeNumber(element: element):
      return "RLPEncodableError: Negative number \(element)"
    }
  }
}

protocol RLPType {}

extension String: RLPType {}

protocol UInts: RLPType {}
extension UInt : UInts {}
extension UInt8 : UInts {}
extension UInt16 : UInts {}
extension UInt32 : UInts {}
extension UInt64 : UInts {}

protocol Ints: RLPType {}
extension Int : Ints {}
extension Int8 : Ints {}
extension Int16 : Ints {}
extension Int32 : Ints {}
extension Int64 : Ints {}


public struct RLPEncoder {
  public static func encode(_ data: Any?) throws -> [UInt8] {
    
    guard let data = data else { return [0x80] } // nil ~ empty byte array ~ empty string
    var res: [UInt8] = []
    
    switch (data) {
    case let data as [UInt8]:
      if (data == []) { return [0xC0] } // empty array
      res = data
      if (res.count != 1 || res[0] > 127) {
        while(res[0] == 0) {
          res.remove(at: 0)
        }
        res = RLPEncoder.encodeLength(UInt(res.count), 128) + res
      }
    case let data as Array<Any>:
      for a in data {
        res += try RLPEncoder.encode(a)
      }
      res = RLPEncoder.encodeLength(UInt(res.count), 192) + res
      
    case let data as String:
      res = [UInt8](data.utf8)
      if (res.count != 1 || res[0] > 127) {
        res = RLPEncoder.encodeLength(UInt(res.count), 128) + res
      }
    case let data as UInt8:
      res = encodeUInt(UInt64(data))
    case let data as UInt16:
      res = encodeUInt(UInt64(data))
    case let data as UInt32:
      res = encodeUInt(UInt64(data))
    case let data as UInt64:
      res = encodeUInt(UInt64(data))
    case let data as UInt:
      res = encodeUInt(UInt64(data))
    case let data as Int8:
      if (data < 0) {throw RLPEncodableError.negativeNumber(element: data)}
      res = encodeUInt(UInt64(data))
    case let data as Int16:
      if (data < 0) {throw RLPEncodableError.negativeNumber(element: data)}
      res = encodeUInt(UInt64(data))
    case let data as Int32:
      if (data < 0) {throw RLPEncodableError.negativeNumber(element: data)}
      res = encodeUInt(UInt64(data))
    case let data as Int64:
      if (data < 0) {throw RLPEncodableError.negativeNumber(element: data)}
      res = encodeUInt(UInt64(data))
    case let data as Int:
      if (data < 0) {throw RLPEncodableError.negativeNumber(element: data)}
      res = encodeUInt(UInt64(data))
    default:
      throw RLPEncodableError.incompatibleType(elementType: data)
    }
    return res
  }
  
  static func encodeUInt(_ u: UInt64) -> [UInt8] {
    var res: [UInt8] = []
    var q = UInt64(u)
    if (q == 0) { return [0x80] }
    if q < 128 {
      res.append(UInt8(q))
    } else {
      var r: UInt8 = 0
      while (q != 0) {
        r = UInt8(q % 256)
        q = q / 256
        res.insert(r, at: 0)
      }
      res = RLPEncoder.encodeLength(UInt(res.count), 128) + res
    }
    return res
  }
  
  static func encodeLength (_ len: UInt, _ offset: UInt8) -> [UInt8] {
    if (len < 56) {
      return [UInt8(len) + offset]
    } else {
      let hexLength = String(format: "%02X", len)
      var lenA: [UInt8] = []
      var q = len
      var r: UInt8 = 0
      while (q != 0) {
        r = UInt8(q % 256)
        q = q / 256
        lenA.insert(r, at: 0)
      }
      
      return [offset + UInt8(55) + UInt8((hexLength.count + 1) / 2)] + lenA
    }
  }
}

enum RLPDecoderError: Error, CustomStringConvertible {
  case invalidData([UInt8])
  
  var description: String {
    switch self {
    case .invalidData(let data):
      return "RLPDecoderError: Invalid data \(data)"
    }
  }
}

struct RLPDecoder {
  
  struct Decoder {
    let data: [UInt8]
    let remainder: [UInt8]
  }
  
  func decode(_ encoded: [UInt8]) throws -> Decoder {
    guard !encoded.isEmpty else {
      return Decoder(data: [], remainder: [])
    }
    
    let firstByte = encoded[0]
    if firstByte <= 0x7f {
      // a single byte whose value is in the [0x00, 0x7f] range, that byte is its own RLP encoding.
      guard encoded.count == 2 else { throw RLPDecoderError.invalidData(encoded) }
      return Decoder(data: [encoded[1]], remainder: Array(encoded.dropFirst(1)))
      
    } else if firstByte <= 0xb7 {
      // if a string is 0-55 bytes long, the RLP encoding consists of a single byte with value 0x80
      // plus the length of the string followed by the string. The range of the first byte is thus [0x80, 0xb7]
      
      var data: [UInt8]
      
      let length = Int(firstByte - 0x7f)
      if firstByte == 0x80  {
        data = []
      } else {
        data = Array(encoded[1..<length])
      }
      return Decoder(data: data, remainder: Array(encoded.dropFirst(length)))
      
    } else if firstByte <= 0xbf {
      // If a string is more than 55 bytes long, the RLP encoding consists of a single
      // byte with value 0xb7 plus the length of the length of the string in binary form,
      // followed by the length of the string, followed by the string.
      
      let slength = Int(firstByte - 0xb6)
      let valueBytes = Array(encoded[1..<slength])
      let stringData = Data(bytes: valueBytes)
      guard let length = Int(stringData.hex(), radix: 16) else {
        throw RLPDecoderError.invalidData(encoded)
      }
      
      let data = Array(encoded[length..<length + slength])
      guard data.count >= length else {
        throw RLPDecoderError.invalidData(encoded)
      }
      return Decoder(data: data, remainder: Array(encoded.dropFirst(length + slength)))
      
    } else if firstByte <= 0xf7 {
      // If the total payload of a list (i.e. the combined length of all its items)
      // is 0-55 bytes long, the RLP encoding consists of a single byte with value 0xc0
      // plus the length of the list followed by the concatenation of the RLP encodings of the items.
      // The range of the first byte is thus [0xc0, 0xf7]
      
      let length = Int(firstByte - 0xbf)
      var innerRemainder = Array(encoded[1..<length])
      
      var decoded = [UInt8]()
      
      do {
        while innerRemainder.count != 0 {
          let d = try decode(innerRemainder)
          decoded.append(contentsOf: d.data)
          innerRemainder = d.remainder
        }
        
        return Decoder(data: decoded, remainder: Array(encoded.dropFirst(length)))
      }
      catch {
        throw RLPDecoderError.invalidData(encoded)
      }
      
    } else {
      // If the total payload of a list is more than 55 bytes long, the RLP encoding consists of a
      // single byte with value 0xf7 plus the length of the length of the payload in binary form,
      // followed by the length of the payload, followed by the concatenation of the RLP encodings of the items.
      // The range of the first byte is thus [0xf8, 0xff].
      
      let slength = Int(firstByte - 0xf6)
      let valueBytes = Array(encoded[1..<slength])
      let stringData = Data(bytes: valueBytes)
      guard let length = Int(stringData.hex(), radix: 16) else {
        throw RLPDecoderError.invalidData(encoded)
      }
      
      let totalLength = slength + length
      guard totalLength <= encoded.count else {
        throw RLPDecoderError.invalidData(encoded)
      }
      
      var decoded = [UInt8]()
      var innerRemainder = Array(encoded[slength..<totalLength])
      guard !innerRemainder.isEmpty else {
        throw RLPDecoderError.invalidData(encoded)
      }
      
      do {
        while innerRemainder.count != 0 {
          let d = try decode(innerRemainder)
          decoded.append(contentsOf: d.data)
          innerRemainder = d.remainder
        }
        
        return Decoder(data: decoded, remainder: Array(encoded.dropFirst(totalLength)))
      }
      catch {
        throw RLPDecoderError.invalidData(encoded)
      }
    }
  }
}
