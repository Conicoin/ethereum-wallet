// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit

struct WalletCreationInfo {
  var mnemonic: [String]
  
  init(mnemonic: [String]) {
    self.mnemonic = mnemonic
  }
}
