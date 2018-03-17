//
//  KeyCrypto.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 17/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import CryptoSwift

struct KeyCrypto: Codable {
  let cipher: String = "aes-128-ctr"
  let kdf: String = "scrypt"
  let ciphertext: String
  let cipherparams: KeyCipherParams
  let kdfparams: KeyKDFParams
  let mac: String
  
  init(ciphertext: String, cipherparams: KeyCipherParams, kdfparams: KeyKDFParams, mac: String) {
    self.ciphertext = ciphertext
    self.cipherparams = cipherparams
    self.kdfparams = kdfparams
    self.mac = mac
  }
  
  init(data: Data, password: String) throws {
    let cipherparams = KeyCipherParams()
    let kdfparams = KeyKDFParams()
    
    let scrypt = KeyScrypt(params: kdfparams)
    let key = try scrypt.calculate(password: password)
    
    let encriptionKey = key[0...15]
    let aesCipher = try AES(key: encriptionKey.bytes, blockMode: .CTR(iv: cipherparams.iv.bytes), padding: .noPadding)
    
    let encryptedKey = try aesCipher.encrypt(data.bytes)
    let prefix = key[(key.count - 16) ..< key.count]
    
    let encryptedData = Data(bytes: encryptedKey)
    var data = Data(capacity: encryptedData.count + prefix.count)
    data.append(prefix)
    data.append(encryptedData)
    
    let mac = data.sha3(.keccak256)
    self.init(ciphertext: encryptedData.toHexString(),
              cipherparams: cipherparams,
              kdfparams: kdfparams,
              mac: mac.toHexString())
  }
}
