//
//  InsuranceContract.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 11/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

struct InsuranceGetPartners: ContractCall {
  
  var method: String {
    return "getPartners()"
  }
  
  var params: [ContractCallParam] {
    return []
  }
}

