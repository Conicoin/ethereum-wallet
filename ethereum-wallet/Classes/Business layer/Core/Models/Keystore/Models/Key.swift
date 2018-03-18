//
//  Key.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct Key: Codable {
  var version: Int = 3
  let id: String
  let address: String
  let crypto: KeyCrypto
  
  init(privateKeyString: String, password: String) throws {
    guard let data = privateKeyString.data(using: .utf8) else {
      throw KeyError.privateIsNotUtf8
    }
    try self.init(privateKey: data, password: password)
  }
  
  init(privateKey: Data, password: String) throws {
    self.id = UUID().uuidString.lowercased()
    self.crypto = try KeyCrypto(data: privateKey, password: password)
    
    let pubKey = Secp256k1.shared.pubicKey(from: privateKey)
    let sha3 = pubKey[1...].sha3(.keccak256)
    self.address = Address(data: sha3[12..<32]).string
  }
}

extension Key {
  enum CodingKeys: String, CodingKey {
    case address
    case version
    case id
    case crypto
  }
  
  enum UppercaseKeys: String, CodingKey {
    case crypto
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    self.version = try values.decode(Int.self, forKey: .version)
    self.id = try values.decode(String.self, forKey: .id)
    self.address = try values.decode(String.self, forKey: .address)
    
    if let crypto = try? values.decode(KeyCrypto.self, forKey: .crypto) {
      self.crypto = crypto
    } else {
      let upperValues = try decoder.container(keyedBy: UppercaseKeys.self)
      self.crypto = try upperValues.decode(KeyCrypto.self, forKey: UppercaseKeys.crypto)
    }
  }
  
}

enum KeyError: Error {
  case privateIsNotUtf8
}

