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
