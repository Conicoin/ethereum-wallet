//
//  InsuranceServiceProtocol.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol InsuranceServiceProtocol {
  func getPartners(completion: @escaping (Result<String>) -> Void)
}
