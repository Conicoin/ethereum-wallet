// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import RealmSwift

class CoinDataStoreService: RealmStorable<Coin>, CoinDataStoreServiceProtocol {
  
  @discardableResult
  func createCoin() -> Coin {
    var coin = Coin()
    coin.balance = Ether(weiValue: 0)
    save(coin)
    return coin
  }
  
  func find(withIso iso: String) -> Coin {
    if let coin = findOne("iso = '\(iso)'") {
      return coin
    }
    return createCoin()
  }
  
  override func save(_ model: Coin) {
    save([model])
  }
  
}
