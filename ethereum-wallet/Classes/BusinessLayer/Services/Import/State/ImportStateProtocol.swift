// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

protocol ImportStateProtocol {
  var importType: ImportState { get }
  var placeholder: String { get }
  var iCloudImportEnabled: Bool { get }
}
