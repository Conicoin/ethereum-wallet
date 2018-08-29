// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

struct KeyCipherParams {
  
  let iv: Data
  
  init() {
    let dataCount = 16
    var data = Data(repeating: 0, count: dataCount)
    let result = data.withUnsafeMutableBytes { p in
      SecRandomCopyBytes(kSecRandomDefault, dataCount, p)
    }
    precondition(result == errSecSuccess, "Random generator failed")
    self.iv = data
  }
}

extension KeyCipherParams: Codable {
  enum CodingKeys: String, CodingKey {
    case iv
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.iv = try values.decodeHexString(forKey: .iv)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(iv.hex(), forKey: .iv)
  }
}
