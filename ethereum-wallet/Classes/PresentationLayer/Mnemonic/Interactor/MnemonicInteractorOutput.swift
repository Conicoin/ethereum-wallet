//
//  MnemonicMnemonicInteractorOutput.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol MnemonicInteractorOutput: class {
  func didReceiveMnemonic(_ mnemonic: [String])
}
