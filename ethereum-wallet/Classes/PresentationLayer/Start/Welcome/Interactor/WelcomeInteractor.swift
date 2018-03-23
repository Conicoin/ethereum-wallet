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
  
  var walletCreator: WalletCreatorProtocol!
  var walletImporter: WalletImporterProtocol!
}


// MARK: - WelcomeInteractorInput

extension WelcomeInteractor: WelcomeInteractorInput {
  
  func createWallet(passcode: String, completion: PinResult?) {
    do {
      try walletCreator.createWallet(with: passcode)
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
  }
  
  func importKey(_ key: Data, passcode: String, completion: PinResult?) {
    do {
      try walletImporter.importKey(key, passcode: passcode)
      completion?(.success(true))
    } catch {
      completion?(.failure(error))
    }
  }

}
