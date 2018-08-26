//
//  ImportMnemonicVerificator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class ImportMnemonicVerificator: ImportVerificatorProtocol {
  
  let mnemonicService: MnemonicServiceProtocol
  
  init(mnemonicService: MnemonicServiceProtocol) {
    self.mnemonicService = mnemonicService
  }
  
  func verifyKey(_ key: String, completion: (Result<WalletKey>) -> Void) {
    do {
      let mnemonic = key.components(separatedBy: " ").filter { $0 != "" }
      _ = try mnemonicService.createSeed(mnemonic: mnemonic, withPassphrase: "")
      completion(.success(.mnemonic(mnemonic)))
    } catch {
      completion(.failure(error))
    }
  }

}
