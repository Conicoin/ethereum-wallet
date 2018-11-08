// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


struct InsuranceGetPartners: ContractCall {
  
  var method: String {
    return "getPartners()"
  }
  
  var params: [ContractCallParam] {
    return []
  }
}

struct InsuranceGetPartner: ContractCall {
  
  let address: Address
  
  var method: String {
    return "getPartner(address)"
  }
  
  var params: [ContractCallParam] {
    return [.address(address)]
  }
}
