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


class WelcomeInteractor {
  weak var output: WelcomeInteractorOutput!
  
  var walletManager: WalletManagerProtocol!
  var keychain: Keychain!
}


// MARK: - WelcomeInteractorInput

extension WelcomeInteractor: WelcomeInteractorInput {
  
  var isRestoring: Bool {
    return keychain.isAccountBackuped
  }
  
  func createWallet(passcode: String, completion: PinResult?) {
    do {
      try walletManager.createWallet(passphrase: passcode)
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
  }
  
  func importPrivateKey(_ key: String, passcode: String, completion: PinResult?) {
    do {
      let data = try Data(hexString: key)
      try walletManager.importWallet(privateKey: data, passphrase: passcode)
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
  }
  
  func importMnemonic(_ mnemonic: String, passcode: String, completion: PinResult?) {
    do {
      let mnemoicWords = mnemonic.components(separatedBy: " ")
      try walletManager.importWallet(mnemonic: mnemoicWords, passphrase: passcode)
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
  }

}
