//
//  InsuranceService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


class InsuranceService: NetworkLoadable, InsuranceServiceProtocol {
  
  let contact: Address
  
  init(contact: Address) {
    self.contact = contact
  }
  
  func getPartners(completion: @escaping (Result<[Address]>) -> Void) {
    let call = InsuranceGetPartners()
    loadObjectJSON(request: call.request(to: contact), queue: .main) { result in
      switch result {
      case .success(let object):
        guard let json = object as? [String: Any], let result = json["result"] as? String else {
          completion(.failure(NetworkError.parseError))
          return
        }
        do {
          let data = Data(hex: result.deleting0x())
          let decoder = ABIDecoder(data: data)
          let decoded = try decoder.decode(type: .dynamicArray(.address))
          completion(.success(decoded.nativeValue as? [Address] ?? []))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func getPartner(address: Address, completion: @escaping (Result<Partner>) -> Void) {
    let call = InsuranceGetPartner(address: address)
    loadObjectJSON(request: call.request(to: contact), queue: .main) { result in
      switch result {
      case .success(let object):
        guard let json = object as? [String: Any], let result = json["result"] as? String else {
          completion(.failure(NetworkError.parseError))
          return
        }
        do {
          let data = Data(hex: result.deleting0x())
          let decoder = ABIDecoder(data: data)
          let decoded = try decoder.decode(type: .tuple([.address, .int(bits: 256), .int(bits: 256)]))
          guard
            let nativeValue = decoded.nativeValue as? [Any], nativeValue.count == 3,
            let address = nativeValue[0] as? Address,
            let rate = nativeValue[1] as? Decimal,
            let deadline = nativeValue[2] as? Decimal else {
            completion(.failure(NetworkError.parseError))
            return
          }
          let partner = Partner.init(address: address, rate: rate, deadline: deadline)
          completion(.success(partner))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
