//
//  InsuranceService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class InsuranceService: NetworkLoadable, InsuranceServiceProtocol {
  
  let address: String
  
  init(address: String) {
    self.address = address
  }
  
  func getPartners(completion: @escaping (Result<String>) -> Void) {
    let call = InsuranceGetPartners()
    let request = RPC.Call(from: nil, to: address, gasLimit: nil, gasPrice: nil, value: nil, data: call.encode(), blockParameter: .latest)
    loadObjectJSON(request: request, queue: .main) { result in
      switch result {
      case .success(let object):
        guard let json = object as? [String: Any], var result = json["result"] as? String, result.count > 2 else {
          completion(.failure(NetworkError.parseError))
          return
        }
        result.removeFirst()
        result.removeFirst()
        
        let data = Data(hex: result)
        print(data.hex())
        
        let array = ["0x86a21a43b3e0406b769a63aa8011fb7c38a15846"]
        do {
          let coded = try RLPEncoder.encode(array)
          print(Data(bytes: coded).hex())
        } catch {
          print(error)
        }
        
//        do {
//          let decoded = try RLPDecoder().decode(data.bytes)
//          print(decoded.data.toHexString())
//        } catch {
//          fatalError(error.localizedDescription)
//        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
