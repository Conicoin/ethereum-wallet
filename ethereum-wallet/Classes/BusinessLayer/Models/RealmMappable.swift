// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit
import RealmSwift


protocol RealmMappable {
  
  associatedtype RealmType: Object
  
  func mapToRealmObject() -> RealmType
  static func mapFromRealmObject(_ object: RealmType) -> Self
  
}
