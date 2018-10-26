// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import ObjectMapper

struct Wallet {
  
  var address: String!
  var localCurrency: String!
  var gasLimit: Decimal!
  
}

// MARK: - RealmMappable

extension Wallet: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmWallet) -> Wallet {
    var wallet = Wallet()
    wallet.address = object.address
    wallet.localCurrency = object.localCurrency
    wallet.gasLimit = Decimal(object.gasLimit)
    return wallet
  }
  
  func mapToRealmObject() -> RealmWallet {
    let realmObject = RealmWallet()
    realmObject.address = address
    realmObject.localCurrency = localCurrency
    realmObject.gasLimit = gasLimit.string
    return realmObject
  }
  
}
