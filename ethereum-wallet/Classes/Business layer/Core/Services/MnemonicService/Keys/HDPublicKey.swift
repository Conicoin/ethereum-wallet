// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import CryptoSwift

struct HDPublicKey {
  let raw: Data
  let chainCode: Data
  private let depth: UInt8
  private let fingerprint: UInt32
  private let childIndex: UInt32
  private let network: Chain
  
  private let hdPrivateKey: HDPrivateKey
  
  init(hdPrivateKey: HDPrivateKey, chainCode: Data, network: Chain, depth: UInt8, fingerprint: UInt32, childIndex: UInt32) {
    self.raw = PublicKey.from(data: hdPrivateKey.raw, compressed: true)
    self.chainCode = chainCode
    self.depth = depth
    self.fingerprint = fingerprint
    self.childIndex = childIndex
    self.network = network
    self.hdPrivateKey = hdPrivateKey
  }
  
  func publicKey() -> PublicKey {
    return PublicKey(privateKey: hdPrivateKey.privateKey())
  }
  
  func extended() -> String {
    var extendedPublicKeyData = Data()
    extendedPublicKeyData += network.publicKeyPrefix.bigEndian
    extendedPublicKeyData += depth.littleEndian
    extendedPublicKeyData += fingerprint.littleEndian
    extendedPublicKeyData += childIndex.littleEndian
    extendedPublicKeyData += chainCode
    extendedPublicKeyData += raw
    let checksum = CryptoHash.sha256sha256(extendedPublicKeyData).prefix(4)
    return Base58.encode(extendedPublicKeyData + checksum)
  }
}
