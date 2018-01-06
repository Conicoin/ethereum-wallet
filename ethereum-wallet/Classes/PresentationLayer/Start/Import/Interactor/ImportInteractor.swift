//
//  ImportImportInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 25/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

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

