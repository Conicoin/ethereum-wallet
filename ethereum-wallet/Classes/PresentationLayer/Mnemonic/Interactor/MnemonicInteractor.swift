// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation


class MnemonicInteractor {
  weak var output: MnemonicInteractorOutput!
  var accountService: AccountServiceProtocol!
  var keychain: Keychain!
}


// MARK: - MnemonicInteractorInput

extension MnemonicInteractor: MnemonicInteractorInput {
  
  func getMnemonic() {
    guard let account = accountService.currentAccount else {
      fatalError("Mnemonic not found")
    }
    output.didReceiveMnemonic(account.key.components(separatedBy: " "))
  }
  
  func setWalletBackuped() {
    keychain.isHdWalletBackuped = true
  }
}
