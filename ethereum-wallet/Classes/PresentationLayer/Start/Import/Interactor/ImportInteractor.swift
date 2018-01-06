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


class ImportInteractor {
  weak var output: ImportInteractorOutput!
  var keystore: KeystoreServiceProtocol!
}


// MARK: - ImportInteractorInput

extension ImportInteractor: ImportInteractorInput {
  
  func importJsonKey(_ jsonKey: String) {
    do {
      guard let data = jsonKey.data(using: .utf8) else {
        throw KeychainError.keyIsInvalid
      }
      try _ = keystore.restoreAccount(with: data, passphrase: "")
    } catch let error {
      // FIXME: Add UTC json key validation
      if error.localizedDescription == "could not decrypt key with given passphrase" {
        let keychain = Keychain()
        keychain.jsonKey = jsonKey.data(using: .utf8)
        output.didConfirmValidJsonKey()
      } else {
        output.didFailed(with: error)
      }
    }
  }

}

