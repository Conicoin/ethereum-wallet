//
//  KeyCipherParams.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
    try container.encode(iv.toHexString(), forKey: .iv)
  }
}
