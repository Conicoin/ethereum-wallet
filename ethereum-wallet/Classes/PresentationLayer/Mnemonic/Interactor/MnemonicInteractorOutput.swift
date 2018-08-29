// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


protocol MnemonicInteractorOutput: class {
  func didReceiveMnemonic(_ mnemonic: [String])
}
