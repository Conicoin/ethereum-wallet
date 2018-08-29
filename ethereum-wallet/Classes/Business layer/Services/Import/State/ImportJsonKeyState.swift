// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class ImportJsonKeyState: ImportStateProtocol {
  
  let importType: ImportState
  let placeholder: String
  let iCloudImportEnabled: Bool
  
  
  init() {
    self.importType = .jsonKey
    self.placeholder = Localized.importJsonTitle()
    self.iCloudImportEnabled = true
  }
  
}
