// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import ObjectMapper

struct Rate: RealmMappable, Equatable {
 
  var value: Double!
  var from: String!
  var to: String!
  
  static func mapFromRealmObject(_ object: RealmRate) -> Rate {
    var rate = Rate()
    rate.value = object.value
    rate.from = object.from
    rate.to = object.to
    return rate
  }
  
  func mapToRealmObject() -> RealmRate {
    let realmObject = RealmRate()
    realmObject.value = value
    realmObject.from = from
    realmObject.to = to
    realmObject.fromTo = "\(from!)-\(to!)"
    return realmObject
  }
  
}

// MARK: - Mapping

extension Rate {
  
  init(from: String, to: String, value: Double) {
    self.from = from
    self.to = to
    self.value = value
  }
  
}

