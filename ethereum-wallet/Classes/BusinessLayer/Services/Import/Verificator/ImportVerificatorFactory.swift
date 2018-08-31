// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

class ImportVerificatorFactory {
  
  let mnemonicService: MnemonicServiceProtocol
  
  init(mnemonicService: MnemonicServiceProtocol) {
    self.mnemonicService = mnemonicService
  }
  
  func create(_ state: ImportState) -> ImportVerificatorProtocol {
    switch state {
    case .jsonKey:
      return ImportJsonVerificator()
    case .privateKey:
      return ImportPrivateVerificator()
    case .mnemonic:
      return ImportMnemonicVerificator(mnemonicService: mnemonicService)
    }
  }

}
