//
//  RealmMappable.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import RealmSwift


protocol RealmMappable {
  
  associatedtype RealmType: Object
  
  init()
  func mapToRealmObject() -> RealmType
  static func mapFromRealmObject(_ object: RealmType) -> Self
  
}
