// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
