// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import Foundation

class RatesNetworkService: NetworkLoadable, RatesNetworkServiceProtocol {
  
  func getRate(currencies: [String], queue: DispatchQueue, completion: @escaping (Result<[Rate]>) -> Void) {
    loadObjectJSON(request: API.Rate.rate(currencies: currencies), queue: queue) { result in
      switch result {
      case .success(let json):
        guard let object = json as? [String: Any] else {
          completion(.failure(NetworkError.parseError))
          return
        }
        
        var rates = [Rate]()
        for key in object.keys {
          if let rateInfo = object[key] as? [String: Double] {
            let newRates = rateInfo.map { Rate(from: key, to: $0.key, value: $0.value) }
            rates.append(contentsOf: newRates)
          }
        }
        
        completion(.success(rates))
        
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

}
