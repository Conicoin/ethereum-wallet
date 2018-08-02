//
//  Key.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import CryptoSwift

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
    
    let pubKey = Secp256k1.generatePublicKey(withPrivateKey: privateKey, compression: false)
    let sha3 = pubKey[1...].sha3(.keccak256)
    self.address = Address(data: sha3[12..<32]).string
  }
  
  func decrypt(password: String) throws -> Data {
    let derivedKey: Data
    switch crypto.kdf {
    case "scrypt":
      let scrypt = KeyScrypt(params: crypto.kdfparams)
      derivedKey = try scrypt.calculate(password: password)
    default:
      throw KeyError.unsupportedKDF
    }
    
    let cryptoCiphertext = try Data(hexString: crypto.ciphertext)
    let cryptoMac = try Data(hexString: crypto.mac)
    let mac = Key.computeMAC(prefix: derivedKey[derivedKey.count - 16 ..< derivedKey.count], key: cryptoCiphertext)
    if mac != cryptoMac {
      throw KeyError.invalidPassword
    }
    
    let decryptionKey = derivedKey[0...15]
    let decryptedPK: [UInt8]
    switch crypto.cipher {
    case "aes-128-ctr":
      let aesCipher = try AES(key: decryptionKey.bytes, blockMode: .CTR(iv: crypto.cipherparams.iv.bytes), padding: .noPadding)
      decryptedPK = try aesCipher.decrypt(cryptoCiphertext.bytes)
    case "aes-128-cbc":
      let aesCipher = try AES(key: decryptionKey.bytes, blockMode: .CBC(iv: crypto.cipherparams.iv.bytes), padding: .noPadding)
      decryptedPK = try aesCipher.decrypt(cryptoCiphertext.bytes)
    default:
      throw KeyError.unsupportedCipher
    }
    
    return Data(bytes: decryptedPK)
  }
  
  static func computeMAC(prefix: Data, key: Data) -> Data {
    var data = Data(capacity: prefix.count + key.count)
    data.append(prefix)
    data.append(key)
    return data.sha3(.keccak256)
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
  case unsupportedKDF
  case invalidPassword
  case unsupportedCipher
}

