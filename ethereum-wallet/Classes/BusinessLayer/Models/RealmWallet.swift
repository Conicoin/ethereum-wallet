// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift

class RealmWallet: Object {
  
  @objc dynamic var primaryKeyConstant = "Wallet_primaryKey"
  @objc dynamic var address = ""
  @objc dynamic var localCurrency = ""
  
  override static func primaryKey() -> String? {
    return "primaryKeyConstant"
  }
  
}
