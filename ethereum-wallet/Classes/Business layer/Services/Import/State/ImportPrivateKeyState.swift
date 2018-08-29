// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class ImportPrivateKeyState: ImportStateProtocol {
  
  let importType: ImportState
  let placeholder: String
  let iCloudImportEnabled: Bool
  
  
  init() {
    self.importType = .privateKey
    self.placeholder = Localized.importPrivateTitle()
    self.iCloudImportEnabled = false
  }
  
}
