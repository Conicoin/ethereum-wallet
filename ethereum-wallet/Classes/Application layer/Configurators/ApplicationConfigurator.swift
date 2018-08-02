// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
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

class ApplicationConfigurator: ConfiguratorProtocol {
  
  let accountService: AccountServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  init(accountService: AccountServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.accountService = accountService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func configure() {
    let keychain = Keychain()
    let wallet = walletDataStoreService.find()
    if wallet.count > 0 && keychain.isAuthorized {
      let isSecureMode = Defaults.mode.isSecureMode
      TabBarModule.create(isSecureMode: isSecureMode).present()
    } else {
      if let account = accountService.currentAccount {
        WelcomeModule.create(.restore(account: account)).present()
      } else {
        WelcomeModule.create(.new).present()
      }
    }
  }
  
}
