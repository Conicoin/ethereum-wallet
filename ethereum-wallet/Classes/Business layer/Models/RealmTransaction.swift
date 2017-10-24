//
//  RealmTransaction.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import RealmSwift

enum CustomRealmError: Error {
  case parsingError
}

class RealmTransaction: Object {
  
  @objc dynamic var txHash = ""
  @objc dynamic var to = ""
  @objc dynamic var amount = 0
  
  override static func primaryKey() -> String? {
    return "txHash"
  }
  
}
