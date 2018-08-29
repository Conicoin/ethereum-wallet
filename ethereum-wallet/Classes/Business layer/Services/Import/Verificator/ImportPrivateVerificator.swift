// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class ImportPrivateVerificator: ImportVerificatorProtocol {
  
  func verifyKey(_ key: String, completion: (Result<WalletKey>) -> Void) {
    guard key.count == 64 else {
      completion(.failure(ImportError.invalidLength))
      return
    }
    
    guard let data = try? Data(hexString: key) else {
      completion(.failure(ImportError.invalidFormat))
      return
    }
    
    completion(.success(.privateKey(data)))
  }
  
}
