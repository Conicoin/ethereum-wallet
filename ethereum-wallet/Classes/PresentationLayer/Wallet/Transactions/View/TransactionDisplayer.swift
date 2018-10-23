// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

struct TransactionDisplayer {
    
    let tx: Transaction
    let isError: Bool
    let status: String?
    let imageName: String
    let title: String
    let amountString: String
    let totalAmount: String
    let fee: String
    let isTokenTransfer: Bool
    let time: Date
    
    init(tx: Transaction) {
        self.tx = tx
        
        let total = Ether(weiValue: (tx.gasUsed * tx.gasPrice) + tx.amount.raw)
        self.totalAmount = total.amountString
        
        let fee = Ether(weiValue: tx.gasUsed * tx.gasPrice)
        self.fee = fee.amountString
        
        if let error = tx.error, !error.isEmpty {
            self.status = Localized.transactionsError()
        } else if tx.isPending {
            self.status = Localized.transactionsPending()
        } else {
            self.status = nil
        }
        
        if let error = tx.error, !error.isEmpty {
            self.imageName = "TxError"
            self.isError = true
        } else {
            self.imageName = tx.isIncoming ? "TxReceived" : "TxSent"
            self.isError = false
        }
        
        let address: String! = tx.isIncoming ? tx.from : tx.to
        let shortAddress = address[0..<4] + "..." + address[address.count - 4..<address.count]
        
        self.title = tx.isIncoming ?
            Localized.transactionsReceived(shortAddress) :
            Localized.transactionsSent(shortAddress)
        
        self.amountString = tx.isIncoming ? "+ \(tx.value.amountString)" : "- \(tx.value.amountString)"
        self.isTokenTransfer = tx.tokenMeta != nil
        self.time = tx.timeStamp
    }
    
}

extension TransactionDisplayer: Equatable {
    
    static func == (lhs: TransactionDisplayer, rhs: TransactionDisplayer) -> Bool {
        return lhs.isError == rhs.isError
            && lhs.status == rhs.status
            && lhs.imageName == rhs.imageName
            && lhs.title == rhs.title
            && lhs.amountString == rhs.amountString
            && lhs.totalAmount == rhs.totalAmount
            && lhs.fee == rhs.fee
            && lhs.time == rhs.time
            && lhs.isTokenTransfer == rhs.isTokenTransfer
    }
    
    
}
