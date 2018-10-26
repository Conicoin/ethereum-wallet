// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

extension Data {
  
  func hex() -> String {
    return map { String(format: "%02x", $0) }
      .joined(separator: "")
  }
  
  init(hexString: String) throws {
    let data = Data(hex: hexString)
    guard data.count > 0 else {
      throw Errors.invalidHexString
    }
    self = data
  }
  
  init(hex: String) {
    var data = Data(capacity: hex.count / 2)
    let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
    regex.enumerateMatches(in: hex, range: NSMakeRange(0, hex.utf16.count)) { match, flags, stop in
      let byteString = (hex as NSString).substring(with: match!.range)
      var num = UInt8(byteString, radix: 16)!
      data.append(&num, count: 1)
    }
    self = data
  }
  
  enum Errors: Error {
    case invalidHexString
  }
  
}

extension KeyedDecodingContainerProtocol {
  
  func decodeHexString(forKey key: Self.Key) throws -> Data {
    let hexString = try decode(String.self, forKey: key)
    return try Data(hexString: hexString)
  }
  
}

