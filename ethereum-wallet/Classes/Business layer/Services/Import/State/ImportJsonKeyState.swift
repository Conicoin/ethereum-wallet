//
//  ImportJsonKeyState.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class ImportJsonKeyState: ImportStateProtocol {
    
    let placeholder: String
    let iCloudImportEnabled: Bool
    
    
    init() {
        self.placeholder = Localized.importJsonTitle()
        self.iCloudImportEnabled = true
    }
    
}
