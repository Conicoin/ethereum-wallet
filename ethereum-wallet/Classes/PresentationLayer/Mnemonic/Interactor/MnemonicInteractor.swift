//
//  MnemonicMnemonicInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 18/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class MnemonicInteractor {
  weak var output: MnemonicInteractorOutput!
  var accountService: AccountServiceProtocol!
}


// MARK: - MnemonicInteractorInput

extension MnemonicInteractor: MnemonicInteractorInput {
  
  func getMnemonic() {
    guard let account = accountService.currentAccount else {
      fatalError("Mnemonic not found")
    }
    output.didReceiveMnemonic(account.key.components(separatedBy: " "))
  }
}
