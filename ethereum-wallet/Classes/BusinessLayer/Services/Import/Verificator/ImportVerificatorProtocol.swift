// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

enum WalletKey {
  case privateKey(Data)
  case jsonKey(Data)
  case mnemonic([String])
}

protocol ImportVerificatorProtocol {
    func verifyKey(_ key: String, completion: (Result<WalletKey>) -> Void)
}
