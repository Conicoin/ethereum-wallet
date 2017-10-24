//
//  RealmStorable.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import RealmSwift


class RealmStorable<PlainType: RealmMappable> {
  
  private var notificationTocken: NotificationToken?

  func observe(updateHandler: @escaping ([PlainType]) -> Void) {
    let realm = try! Realm()
    let objects = realm.objects(PlainType.RealmType.self)
    notificationTocken?.invalidate()
    notificationTocken = objects.observe { changes in
      updateHandler(objects.map { PlainType.mapFromRealmObject($0) } )
    }
  }
  
  func find() -> [PlainType] {
    let realm = try! Realm()
    return realm.objects(PlainType.RealmType.self).flatMap() { PlainType.mapFromRealmObject($0) }
  }
  
  func find(_ predicateFormat: String, _ args: Any...) -> [PlainType] {
    let realm = try! Realm()
    return realm.objects(PlainType.RealmType.self)
      .filter(predicateFormat, args)
      .flatMap() { PlainType.mapFromRealmObject($0) }
  }
  
  func findOne(_ predicateFormat: String, _ args: Any...) -> PlainType? {
    let realm = try! Realm()
    return realm.objects(PlainType.RealmType.self).filter(predicateFormat, args).flatMap() { PlainType.mapFromRealmObject($0) }.first
  }
  
  func save(_ model: PlainType) {
    let realm = try! Realm()
    
    try! realm.write {
      realm.add(model.mapToRealmObject(), update: true)
    }
  }
  
  func save(_ models: [PlainType]) {
    let realm = try! Realm()
    
    try! realm.write {
      realm.add(models.map({ $0.mapToRealmObject() }), update: true)
    }
  }
  
}
