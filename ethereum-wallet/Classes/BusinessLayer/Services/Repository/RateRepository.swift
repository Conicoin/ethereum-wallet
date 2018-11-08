// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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
    
    self.rates = rateDataStoreService.find()
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
