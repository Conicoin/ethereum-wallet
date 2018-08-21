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


class ImportInteractor {
  weak var output: ImportInteractorOutput!
  
  var keychain: Keychain!
  var verificator: ImportVerificatorProtocol!
  var walletManager: WalletManagerProtocol!
}


// MARK: - ImportInteractorInput

extension ImportInteractor: ImportInteractorInput {
  
  func verifyKey(_ key: String) {
    verificator.verifyKey(key) { result in
      switch result {
      case .success(let key):
        output.didConfirmValidKey(key)
      case .failure(let error):
        output.didFailed(with: error)
      }
    }
  }
  
  func importKey(_ key: WalletKey, passcode: String, completion: PinResult?) {
    DispatchQueue.global().async { [unowned self] in
      do {
       
        switch key {
        case .jsonKey(let jsonKey):
          try self.walletManager.importWallet(jsonKey: jsonKey, passphrase: passcode)
        case .privateKey(let privateKey):
          try self.walletManager.importWallet(privateKey: privateKey, passphrase: passcode)
        case .mnemonic(let mnemonic):
          try self.walletManager.importWallet(mnemonic: mnemonic, passphrase: passcode)
          self.keychain.isHdWalletBackuped = true
        }
        
        DispatchQueue.main.async {
          completion?(.success(true))
        }
      } catch {
        DispatchQueue.main.async {
          completion?(.failure(error))
        }
      }
    }
    
  }
  
}

