//
//  Wallet.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit

struct Wallet {
  
  var balance: Int64!
  var address: String!

}

// MARK: - RealmMappable

extension Wallet: RealmMappable {
  
  static func mapFromRealmObject(_ object: RealmWallet) -> Wallet {
    var wallet = Wallet()
    wallet.balance = object.balance
    wallet.address = object.address
    return wallet
  }
  
  func mapToRealmObject() -> RealmWallet {
    let realmObject = RealmWallet()
    realmObject.address = address
    realmObject.balance = balance
    return realmObject
  }
  
}
