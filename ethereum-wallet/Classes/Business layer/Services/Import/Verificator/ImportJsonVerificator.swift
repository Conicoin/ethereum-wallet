//
//  ImportJsonVerificator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
