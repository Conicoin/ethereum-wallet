//
//  Transaction.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 20/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

enum CustomRealmError: Error {
    case parsingError
}

class Transaction: Object, ImmutableMappable {
    
    @objc dynamic var blockNumber = ""
    @objc dynamic var timeStamp = ""
    @objc dynamic var txHash = ""
    @objc dynamic var blockHash = ""
    @objc dynamic var transactionIndex = ""
    @objc dynamic var from = ""
    @objc dynamic var to = ""
    @objc dynamic var confirmations = ""
    @objc dynamic var input = ""
    @objc dynamic var contractAddress = ""
    @objc dynamic var gasPrice = ""
    @objc dynamic var gas = ""
    
    required convenience init(map: Map) throws {
        self.init()

        blockNumber      = try map.value("blockNumber")
        timeStamp        = try map.value("timeStamp")
        txHash           = try map.value("hash")
        blockHash        = try map.value("blockHash")
        transactionIndex = try map.value("transactionIndex")
        from             = try map.value("from")
        to               = try map.value("to")
        confirmations    = try map.value("confirmations")
        input            = try map.value("input")
        contractAddress  = try map.value("contractAddress")
        gasPrice         = try map.value("gasPrice")
        gas              = try map.value("gas")
    }
    
    override static func primaryKey() -> String? {
        return "txHash"
    }

}


// MARK: - Utils

extension Transaction {
    
    class func getTransactions(for address: String) -> Results<Transaction> {
        NSLog("1")
        let realm = try! Realm()
        NSLog("2")
        let predicate = NSPredicate(format: "to == %@ || from == %@", address, address)
        NSLog("3")
        return realm.objects(Transaction.self).filter(predicate)
    }
    
    class func save(_ transactions: [Transaction]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(transactions, update: true)
        }
    }
    
}
