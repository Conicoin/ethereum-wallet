//
//  ImportPrivatePostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 16/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import Alamofire

class ImportPrivatePostProcess: ImportPostProcessProtocol {
  
  func verifyKey(_ key: String, completion: (Result<Data>) -> Void) {
    guard key.count == 64 else {
      completion(.failure(ImportError.invalidLength))
      return
    }
    
    guard let data = try? Data(hexString: key) else {
      completion(.failure(ImportError.invalidFormat))
      return
    }
    
    completion(.success(data))
  }
  
}
