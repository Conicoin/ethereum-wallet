//
//  TransactionDisplayerGroup.swift
//  ethereum-wallet
//
//  Created by Nikita Medvedev on 15/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import UIKit

class TransactionDisplayerSection {
    let date: Date
    var transactions: [TransactionDisplayer] =  []
    
    init(with date: Date) {
        self.date = date
    }
    
    func append(_ transaction: TransactionDisplayer) {
        transactions.append(transaction)
        transactions.sort { $0.time > $1.time }
    }
    
    func transaction(for hash: String) -> TransactionDisplayer? {
        return transactions.first(where: { $0.tx.txHash == hash })
    }
}
