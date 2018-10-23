// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation
import CryptoSwift

struct HDPrivateKey {
  let raw: Data
  let chainCode: Data
  private let depth: UInt8
  private let fingerprint: UInt32
  private let childIndex: UInt32
  private let network: Chain
  
  init(seed: Data, network: Chain) {
    let output = CryptoHash.hmacsha512(seed, key: "Bitcoin seed".data(using: .ascii)!)
    self.raw = output[0..<32]
    self.chainCode = output[32..<64]
    self.depth = 0
    self.fingerprint = 0
    self.childIndex = 0
    self.network = network
  }
  
  private init(hdPrivateKey: Data, chainCode: Data, depth: UInt8, fingerprint: UInt32, index: UInt32, network: Chain) {
    self.raw = hdPrivateKey
    self.chainCode = chainCode
    self.depth = depth
    self.fingerprint = fingerprint
    self.childIndex = index
    self.network = network
  }
  
  func privateKey() -> PrivateKey {
    return PrivateKey(raw: Data(hex: "0x") + raw)
  }
  
  func hdPublicKey() -> HDPublicKey {
    return HDPublicKey(hdPrivateKey: self, chainCode: chainCode, network: network, depth: depth, fingerprint: fingerprint, childIndex: childIndex)
  }
  
  func extended() -> String {
    var extendedPrivateKeyData = Data()
    extendedPrivateKeyData += network.privateKeyPrefix.bigEndian
    extendedPrivateKeyData += depth.littleEndian
    extendedPrivateKeyData += fingerprint.littleEndian
    extendedPrivateKeyData += childIndex.littleEndian
    extendedPrivateKeyData += chainCode
    extendedPrivateKeyData += UInt8(0)
    extendedPrivateKeyData += raw
    let checksum = CryptoHash.sha256sha256(extendedPrivateKeyData).prefix(4)
    return Base58.encode(extendedPrivateKeyData + checksum)
  }
  
  func derived(at index: UInt32, hardens: Bool = false) throws -> HDPrivateKey {
    guard (0x80000000 & index) == 0 else {
      fatalError("Invalid index \(index)")
    }
    
    let keyDeriver = KeyDerivation(
      privateKey: raw,
      publicKey: hdPublicKey().raw,
      chainCode: chainCode,
      depth: depth,
      fingerprint: fingerprint,
      childIndex: childIndex
    )
    
    guard let derivedKey = keyDeriver.derived(at: index, hardened: hardens) else {
      throw Errors.keyDerivateionFailed
    }
    
    return HDPrivateKey(
      hdPrivateKey: derivedKey.privateKey!,
      chainCode: derivedKey.chainCode,
      depth: derivedKey.depth,
      fingerprint: derivedKey.fingerprint,
      index: derivedKey.childIndex,
      network: network
    )
  }
  
  enum Errors: Error {
    case keyDerivateionFailed
  }
}

