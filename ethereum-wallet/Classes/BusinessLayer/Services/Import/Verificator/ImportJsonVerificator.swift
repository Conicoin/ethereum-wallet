// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class ImportJsonVerificator: ImportVerificatorProtocol {
  
  func verifyKey(_ jsonKey: String, completion: (Result<WalletKey>) -> Void) {
    do {
      guard let data = jsonKey.data(using: .utf8) else {
        throw KeychainError.keyIsInvalid
      }

      _ = try JSONDecoder().decode(Key.self, from: data)
      completion(.success(.jsonKey(data)))
    } catch {
      completion(.failure(error))
    }
  }
  
}
