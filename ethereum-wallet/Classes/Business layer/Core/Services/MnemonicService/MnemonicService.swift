//
//  MnemonicService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import CryptoSwift

protocol MnemonicServiceProtocol {
  func create(strength: MnemonicService.Strength, language: WordList) -> [String]
  func create(entropy: Data, language: WordList) -> [String]
  func createSeed(mnemonic: [String], withPassphrase passphrase: String) throws -> Data
}

class MnemonicService: MnemonicServiceProtocol {
  
  enum Strength: Int {
    case normal = 128
    case hight = 256
  }
  
  func create(strength: Strength, language: WordList) -> [String] {
    let byteCount = strength.rawValue / 8
    var bytes = Data(count: byteCount)
    _ = bytes.withUnsafeMutableBytes { SecRandomCopyBytes(kSecRandomDefault, byteCount, $0) }
    return create(entropy: bytes, language: language)
  }
  
  func create(entropy: Data, language: WordList) -> [String] {
    let entropybits = String(entropy.flatMap { ("00000000" + String($0, radix: 2)).suffix(8) })
    let hashBits = String(entropy.sha256().flatMap { ("00000000" + String($0, radix: 2)).suffix(8) })
    let checkSum = String(hashBits.prefix((entropy.count * 8) / 32))
    
    let words = language.words
    let concatenatedBits = entropybits + checkSum
    
    var mnemonic: [String] = []
    for index in 0..<(concatenatedBits.count / 11) {
      let startIndex = concatenatedBits.index(concatenatedBits.startIndex, offsetBy: index * 11)
      let endIndex = concatenatedBits.index(startIndex, offsetBy: 11)
      let wordIndex = Int(strtoul(String(concatenatedBits[startIndex..<endIndex]), nil, 2))
      mnemonic.append(String(words[wordIndex]))
    }
    
    return mnemonic
  }
  
  func createSeed(mnemonic: [String], withPassphrase passphrase: String) throws -> Data {
    let words = WordList.english.words + WordList.japanese.words
    guard !mnemonic.map({ words.contains($0) }).contains(false) else {
      throw ImportError.invalidMnemonic
    }
    let password = mnemonic.joined(separator: " ").toData()
    let salt = ("mnemonic" + passphrase).toData()
    let seed = PKCS5.pbkdf2(password, salt: salt, iterations: 2048, keyLength: 64)
    return Data(seed)
  }
  
}
