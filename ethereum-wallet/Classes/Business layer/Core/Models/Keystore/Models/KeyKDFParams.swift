//
//  KeyKDFParams.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct KeyKDFParams {
  var dklen: Int = 32
  var n: Int = 1 << 12
  var r: Int = 8
  var p: Int = 6
  let salt: Data
  
  init() {
    let count = 32
    var data = Data(repeating: 0, count: count)
    let result = data.withUnsafeMutableBytes { p in
      SecRandomCopyBytes(kSecRandomDefault, count, p)
    }
    precondition(result == errSecSuccess, "Random generator failed")
    salt = data
  }
  
  func validate() -> Errors? {
    if dklen > ((1 << 32 as Int64) - 1 as Int64) * 32 {
      return Errors.desiredKeyLengthTooLarge
    }
    if UInt64(r) * UInt64(p) >= (1 << 30) {
      return Errors.blockSizeTooLarge
    }
    if n & (n - 1) != 0 || n < 2 {
      return Errors.invalidCostFactor
    }
    if (r > Int.max / 128 / p) || (n > Int.max / 128 / r) {
      return Errors.overflow
    }
    return nil
  }
  
  public enum Errors: Error {
    case desiredKeyLengthTooLarge
    case blockSizeTooLarge
    case invalidCostFactor
    case overflow
  }
  
}

extension KeyKDFParams: Codable {
    
    enum CodingKeys: String, CodingKey {
        case dklen
        case n
        case r
        case p
        case salt
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dklen = try values.decode(Int.self, forKey: .dklen)
        n = try values.decode(Int.self, forKey: .n)
        r = try values.decode(Int.self, forKey: .r)
        p = try values.decode(Int.self, forKey: .p)
        salt = try values.decodeHexString(forKey: .salt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dklen, forKey: .dklen)
        try container.encode(n, forKey: .n)
        try container.encode(r, forKey: .r)
        try container.encode(p, forKey: .p)
        try container.encode(salt.hex(), forKey: .salt)
    }
    
}
