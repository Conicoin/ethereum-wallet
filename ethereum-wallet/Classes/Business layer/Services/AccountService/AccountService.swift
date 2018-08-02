//
//  AccountService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 02/08/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol AccountServiceProtocol {
  var currentAccount: Account? { get }
}

class AccountService: AccountServiceProtocol {
  
  let keychain: Keychain
  
  init(keychain: Keychain) {
    self.keychain = keychain
  }
  
  var currentAccount: Account? {
    guard keychain.accounts.count > keychain.currentAccount else {
      return nil
    }
    return keychain.accounts[keychain.currentAccount]
  }

}
