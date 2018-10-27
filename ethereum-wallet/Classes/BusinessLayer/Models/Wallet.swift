// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import ObjectMapper

struct Wallet {
  
  var address: String!
  var localCurrency: String!
}

// MARK: - RealmMappable

extension Wallet: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmWallet) -> Wallet {
    var wallet = Wallet()
    wallet.address = object.address
    wallet.localCurrency = object.localCurrency
    return wallet
  }
  
  func mapToRealmObject() -> RealmWallet {
    let realmObject = RealmWallet()
    realmObject.address = address
    realmObject.localCurrency = localCurrency
    return realmObject
  }
  
}
