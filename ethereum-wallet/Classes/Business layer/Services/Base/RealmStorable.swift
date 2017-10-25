//  MIT License
//
//  Copyright (c) 2017 Artur Guseinov
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
