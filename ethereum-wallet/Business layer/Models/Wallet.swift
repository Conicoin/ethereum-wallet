//
//  Wallet.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import RealmSwift

class Wallet: Object {
    
    dynamic var privateKey = Constants.Realm.walletPrivateKey
    dynamic var balance: Int64 = 0
    dynamic var address: String = ""

    override static func primaryKey() -> String? {
        return "privateKey"
    }
    
}


// MARK: - Utils

extension Wallet {
    
    class func createWithAddress(_ address: String) {
        let wallet = Wallet()
        wallet.address = address
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(wallet, update: true)
        }
    }
    
    class func returnWallet() -> Wallet {
        let realm = try! Realm()
        return realm.objects(Wallet.self).first!
    }
    
    func updateBalance(_ balance: Int64) {
        let realm = try! Realm()
        try! realm.write {
            self.balance = balance
        }
    }
    
}
