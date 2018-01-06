//
//  TokenDataStoreService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 13/12/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

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
