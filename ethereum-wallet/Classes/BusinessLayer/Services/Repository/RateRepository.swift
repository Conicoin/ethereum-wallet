//
//  RateRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol RateRepository {
  var rates: [Rate] { get }
  func addObserver(id: Identifier, fire: Bool, callback: @escaping ([Rate]) -> Void)
  func removeObserver(id: Identifier)
}

class RateRepositoryService: RateRepository {
  
  var rates: [Rate] = []
  
  let channel: Channel<[Rate]>
  let rateDataStoreService: RatesDataStoreServiceProtocol
  init(channel: Channel<[Rate]>, rateDataStoreService: RatesDataStoreServiceProtocol) {
    self.channel = channel
    
    // To not release notification block
    self.rateDataStoreService = rateDataStoreService
    
    rateDataStoreService.observe { rates in
      self.rates = rates
      channel.send(rates)
    }
  }
  
  func addObserver(id: Identifier, fire: Bool, callback: @escaping ([Rate]) -> Void) {
    if fire {
      callback(rates)
    }
    let observer = Observer<[Rate]>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  func removeObserver(id: Identifier) {
    channel.removeObserver(withId: id)
  }
  
}
