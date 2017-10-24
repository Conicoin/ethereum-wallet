//
//  RealmWallet.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import RealmSwift

class RealmWallet: Object {
    
  @objc dynamic var privateKey = "Wallet_primaryKey"
  @objc dynamic var balance: Int64 = 0
  @objc dynamic var address: String = ""

    override static func primaryKey() -> String? {
        return "privateKey"
    }
    
}
