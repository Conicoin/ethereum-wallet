//
//  WalletCreationInfo.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 30/06/2018.
//  Copyright © 2018 Universa. All rights reserved.
//

import UIKit

struct WalletCreationInfo {
  var mnemonic: [String]
  
  init(mnemonic: [String]) {
    self.mnemonic = mnemonic
  }
}
