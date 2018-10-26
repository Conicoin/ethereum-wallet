//
//  InsuranceServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol InsuranceServiceProtocol {
  func getPartners(completion: @escaping (Result<[Address]>) -> Void)
  func getPartner(address: Address, completion: @escaping (Result<Partner>) -> Void)
}
