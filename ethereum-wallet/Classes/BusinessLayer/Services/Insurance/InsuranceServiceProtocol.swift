// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol InsuranceServiceProtocol {
  func getPartners(completion: @escaping (Result<[Address]>) -> Void)
  func getPartner(address: Address, completion: @escaping (Result<Partner>) -> Void)
}
