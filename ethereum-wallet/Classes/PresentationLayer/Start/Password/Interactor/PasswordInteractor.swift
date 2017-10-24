//
//  PasswordPasswordInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation


class PasswordInteractor {
  weak var output: PasswordInteractorOutput!
  
  var ethereumService: EthereumCoreProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
}


// MARK: - PasswordInteractorInput

extension PasswordInteractor: PasswordInteractorInput {
  
  func createWallet(address: String) {
    walletDataStoreService.createWallet(address: address)
    Defaults.isAuthorized = true
  }
  
  func createAccount(passphrase: String) {
    do {
      let account = try ethereumService.createAccount(passphrase: passphrase)
      let jsonKey = try ethereumService.jsonKey(for: account, passphrase: passphrase)
      let keychain = Keychain()
      keychain.jsonKey = jsonKey
      keychain.firstEnterDate = Date()
      output.didReceive(account: Account(address: account.getAddress().getHex()))
    } catch {
      output.didFailedAccountReceiving(with: error)
    }
  }
  
  func restoreAccount(passphrase: String) {
    do {
      let keychain = Keychain()
      let jsonKey = try keychain.getJsonKey()
      let account = try ethereumService.restoreAccount(with: jsonKey, passphrase: passphrase)
      output.didReceive(account: Account(address: account.getAddress().getHex()))
    } catch {
      output.didFailedAccountReceiving(with: error)
    }
  }

}
