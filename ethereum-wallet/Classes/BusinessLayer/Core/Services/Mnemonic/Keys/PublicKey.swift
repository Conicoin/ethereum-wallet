// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import CryptoSwift

struct PublicKey {
  
  let raw: Data
  
  init(raw: Data) {
    self.raw = raw
  }
  
  init(privateKey: PrivateKey) {
    self.init(raw: Data(hex: "0x") + PublicKey.from(data: privateKey.raw, compressed: false))
  }
  
  private var addressData: Data {
    let sha = SHA3(variant: .keccak256)
    let data = Data(sha.calculate(for: raw.dropFirst().bytes))
    return data.suffix(20)
  }
  
  func generateAddress() -> String {
    return Address(data: addressData).string
  }
  
  static func from(data: Data, compressed: Bool) -> Data {
    return Secp256k1.generatePublicKey(withPrivateKey: data, compression: compressed)
  }
}
