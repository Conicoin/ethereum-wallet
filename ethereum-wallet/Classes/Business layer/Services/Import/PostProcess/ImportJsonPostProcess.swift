//
//  ImportJsonPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import Alamofire

class ImportJsonPostProcess:  ImportPostProcessProtocol {
  
  let keystore: KeystoreServiceProtocol
  
  init(keystore: KeystoreServiceProtocol) {
    self.keystore = keystore
  }
  
  func verifyKey(_ jsonKey: String, completion: (Result<String>) -> Void) {
    do {
      guard let data = jsonKey.data(using: .utf8) else {
        throw KeychainError.keyIsInvalid
      }
      try _ = keystore.restoreAccount(with: data, passphrase: "")
    } catch let error {
      // FIXME: Add UTC json key validation
      if error.localizedDescription == "could not decrypt key with given passphrase" {
        completion(.success(jsonKey))
      } else {
        completion(.failure(error))
      }
    }
  }
  
}
