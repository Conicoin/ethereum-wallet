//
//  ImportPrivateKeyState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

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
