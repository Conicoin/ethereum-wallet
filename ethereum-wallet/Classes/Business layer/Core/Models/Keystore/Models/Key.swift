//
//  Key.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct Key: Codable {
  let version: Int = 3
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
    case crypto = "Crypto"
  }
}

enum KeyError: Error {
  case privateIsNotUtf8
}

