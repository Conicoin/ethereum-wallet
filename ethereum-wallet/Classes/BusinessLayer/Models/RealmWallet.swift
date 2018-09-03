// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import RealmSwift

class RealmWallet: Object {
  
  @objc dynamic var privateKey = "Wallet_primaryKey"
  @objc dynamic var address = ""
  @objc dynamic var localCurrency = ""
  @objc dynamic var gasLimit: String = "0"
  
  override static func primaryKey() -> String? {
    return "privateKey"
  }
  
}
