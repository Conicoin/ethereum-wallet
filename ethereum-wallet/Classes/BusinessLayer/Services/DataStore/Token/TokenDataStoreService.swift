// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift

class TokenDataStoreService: RealmStorable<Token>, TokenDataStoreServiceProtocol {
  
  override func save(_ models: [Token]) {
    let realm = try! Realm()
    try! realm.write {
      let models = models.map { token -> RealmToken in
        let realmObject = token.mapToRealmObject()
        if let oldToken = realm.objects(RealmToken.self).filter("name = '\(token.balance.name)'").first {
          if token.rates.isEmpty {
            realmObject.rates = oldToken.rates
          }
        }
        return realmObject
      }
      realm.add(models, update: true)
    }
  }
  
}
