// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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
      keychain.passphrase = passphrase
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
