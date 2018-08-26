//
//  ImportVerificatorFactory.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
