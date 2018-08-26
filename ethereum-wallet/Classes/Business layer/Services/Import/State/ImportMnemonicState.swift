//
//  ImportMnemonicState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class ImportMnemonicState: ImportStateProtocol {
  
  let importType: ImportState
  let placeholder: String
  let iCloudImportEnabled: Bool
  
  
  init() {
    self.importType = .mnemonic
    self.placeholder = Localized.importMnemonicTitle()
    self.iCloudImportEnabled = false
  }
  
}
