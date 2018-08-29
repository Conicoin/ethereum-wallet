// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov



import RealmSwift

class RealmRate: Object {
  
  @objc dynamic var value: Double = 0.0
  @objc dynamic var from: String = ""
  @objc dynamic var to: String = ""
  @objc dynamic var fromTo: String = ""
  
  
  override static func primaryKey() -> String? {
    return "fromTo"
  }

}
