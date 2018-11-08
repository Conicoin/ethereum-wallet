// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


protocol RatesUpdater {
  func start()
  func stop()
  func update()
}

class RatesUpdaterService: RatesUpdater {
  
  let id = Identifier()
  var tokensIso = Set<String>()
  var queue = DispatchQueue(label: "BalanceUpdaterQueue")
  var interval = 75
  var timer: DispatchSourceTimer?
  
  let tokenIndexer: TokenIndexer
  let rateDataStoreService: RatesDataStoreServiceProtocol
  let rateNetworkService: RatesNetworkServiceProtocol
  init(tokenIndexer: TokenIndexer,
       rateDataStoreService: RatesDataStoreServiceProtocol,
       rateNetworkService: RatesNetworkServiceProtocol) {
    self.tokenIndexer = tokenIndexer
    self.rateDataStoreService = rateDataStoreService
    self.rateNetworkService = rateNetworkService
    
    tokenIndexer.start(id: id) { viewModels in
      let isos = viewModels.map { $0.currency.iso }
      let set = Set(isos)
      
      let diff = set.symmetricDifference(self.tokensIso)
      self.updateRates(for: diff)
      self.tokensIso = set
    }
  }
  
  func start() {
    timer = Timer.createDispatchTimer(interval: .seconds(interval),
                                      leeway: .seconds(0),
                                      queue: queue) { [unowned self] in
                                        self.updateTick()
    }
  }
  
  func stop() {
    timer?.cancel()
    timer = nil
  }
  
  func update() {
    updateTick()
  }
  
  // MARK: Privates
  
  private func updateTick() {
    var currencies = tokensIso
    currencies.insert("ETH")
    updateRates(for: currencies)
  }
  
  private func updateRates(for currencies: Set<String>) {
    guard !currencies.isEmpty else { return }
    
    rateNetworkService.getRate(currencies: Array(currencies), queue: .global()) { result in
      switch result {
      case .success(let rates):
        self.rateDataStoreService.save(rates)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
