// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift

struct Coin {
  
  var balance: Currency!
  var rates = [Rate]()
  var lastUpdateTime = Date()
  
}

// MARK: - RealmMappable

extension Coin: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmCoin) -> Coin {
    var coin = Coin()
    coin.balance = Ether(weiString: object.balance)
    coin.rates = object.rates.map { Rate.mapFromRealmObject($0) }
    coin.lastUpdateTime = object.lastUpdateTime
    return coin
  }
  
  func mapToRealmObject() -> RealmCoin {
    let realmObject = RealmCoin()
    realmObject.balance = balance.raw.string
    realmObject.name = balance.name
    realmObject.iso = balance.symbol
    realmObject.rates.append(objectsIn: rates.map { $0.mapToRealmObject() })
    realmObject.lastUpdateTime = lastUpdateTime
    return realmObject
  }
  
}
