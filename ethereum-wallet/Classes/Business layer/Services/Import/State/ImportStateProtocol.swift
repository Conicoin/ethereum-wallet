//
//  ImportStateProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol ImportStateProtocol {
  var importType: ImportState { get }
  var placeholder: String { get }
  var iCloudImportEnabled: Bool { get }
}
