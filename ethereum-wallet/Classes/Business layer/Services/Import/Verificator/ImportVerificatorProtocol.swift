//
//  ImportVerificatorProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

enum WalletKey {
  case privateKey(Data)
  case jsonKey(Data)
  case mnemonic([String])
}

protocol ImportVerificatorProtocol {
    func verifyKey(_ key: String, completion: (Result<WalletKey>) -> Void)
}
