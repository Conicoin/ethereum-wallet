// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import RealmSwift

class CoinDataStoreService: RealmStorable<Coin>, CoinDataStoreServiceProtocol {
    
  func createCoin() {
    var coin = Coin()
    coin.balance = Ether(weiValue: 0)
    save(coin)
  }
  
  func find(withIso iso: String) -> Coin? {
    return findOne("iso = '\(iso)'")
  }
  
  override func save(_ model: Coin) {
    save([model])
  }
  
  override func save(_ models: [Coin]) {
    let realm = try! Realm()
    try! realm.write {
      let models = models.map { coin -> RealmCoin in
        let realmObject = coin.mapToRealmObject()
        if let oldCoin = realm.objects(RealmCoin.self).filter("name = '\(coin.balance.name)'").first {
          if coin.rates.isEmpty {
            realmObject.rates = oldCoin.rates
          }
        }
        return realmObject
      }
      realm.add(models, update: true)
    }
  }
  
}
