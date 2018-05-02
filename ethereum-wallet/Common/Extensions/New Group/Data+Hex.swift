//
//  Data+Hex.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

extension Data {
  
  func hex() -> String {
    return map { String(format: "%02x", $0) }
      .joined(separator: "")
  }
  
  init(hexString: String) throws {
    var data = Data(capacity: hexString.count / 2)
    
    let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
    regex.enumerateMatches(in: hexString, range: NSMakeRange(0, hexString.utf16.count)) { match, flags, stop in
      let byteString = (hexString as NSString).substring(with: match!.range)
      var num = UInt8(byteString, radix: 16)!
      data.append(&num, count: 1)
    }
    
    guard data.count > 0 else {
      throw Errors.invalidHexString
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

