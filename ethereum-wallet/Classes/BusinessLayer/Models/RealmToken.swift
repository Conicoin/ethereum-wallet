// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift

class RealmToken: Object {
  
  @objc dynamic var balance: String = "0"
  @objc dynamic var name: String = ""
  @objc dynamic var iso: String = ""
  @objc dynamic var address: String = ""
  @objc dynamic var decimals: Int = 0
  @objc dynamic var lastUpdateTime: Date = .distantPast
  var rates = List<RealmRate>()
  
  override static func primaryKey() -> String? {
    return "address"
  }

}
