// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

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
