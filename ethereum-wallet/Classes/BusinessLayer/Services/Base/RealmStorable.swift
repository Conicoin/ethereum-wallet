// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift

enum Changes<PlainType: RealmMappable> {
  case initial(objects: [PlainType])
  case update(objects: [PlainType], deleteons: [Int], insertions: [Int], modifications: [Int])
}

class RealmStorable<PlainType: RealmMappable> {
  
  var notificationToken: NotificationToken?
  
  deinit {
    notificationToken?.invalidate()
    notificationToken = nil
  }
  
  func observe(updateHandler: @escaping ([PlainType]) -> Void) {
    let realm = try! Realm()
    let objects = realm.objects(PlainType.RealmType.self)
    notificationToken?.invalidate()
    notificationToken = objects.observe { changes in
      updateHandler(objects.map { PlainType.mapFromRealmObject($0) } )
    }
  }
  
  func observe(predicate: String, updateHandler: @escaping ([PlainType]) -> Void) {
    let realm = try! Realm()
    let objects = realm.objects(PlainType.RealmType.self).filter(predicate)
    notificationToken?.invalidate()
    notificationToken = objects.observe { changes in
      updateHandler(objects.map { PlainType.mapFromRealmObject($0) } )
    }
  }
  
  func observeChanges(updateHandler: @escaping (Changes<PlainType>) -> Void) {
    let realm = try! Realm()
    let objects = realm.objects(PlainType.RealmType.self)
    notificationToken?.invalidate()
    notificationToken = objects.observe { changes in
      switch changes {
      case let .initial(objects):
        let plainObjects: [PlainType] = objects.map { PlainType.mapFromRealmObject($0) }
        updateHandler(Changes.initial(objects: plainObjects))
      case let .update(objects, deletions, insertions, modifications):
        let plainObjects: [PlainType] = objects.map { PlainType.mapFromRealmObject($0) }
        updateHandler(Changes.update(objects: plainObjects, deleteons: deletions, insertions: insertions, modifications: modifications))
      case .error(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func find() -> [PlainType] {
    let realm = try! Realm()
    return realm.objects(PlainType.RealmType.self).compactMap() { PlainType.mapFromRealmObject($0) }
  }
  
  func find(_ predicateString: String) -> [PlainType] {
    let realm = try! Realm()
    return realm.objects(PlainType.RealmType.self)
      .filter(predicateString)
      .compactMap() { PlainType.mapFromRealmObject($0) }
  }
  
  func findOne(_ predicateString: String) -> PlainType? {
    let realm = try! Realm()
    return realm.objects(PlainType.RealmType.self).filter(predicateString).compactMap() { PlainType.mapFromRealmObject($0) }.first
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
