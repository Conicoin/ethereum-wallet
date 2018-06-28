// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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
