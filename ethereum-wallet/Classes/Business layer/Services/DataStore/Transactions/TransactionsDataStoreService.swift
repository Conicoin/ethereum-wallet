// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


import Foundation
import RealmSwift

class TransactionsDataStoreService: RealmStorable<Transaction>, TransactionsDataStoreServiceProtocol {
  
  typealias PlainType = Transaction
  
  func getTransactions() -> [Transaction] {
    return find()
  }
  
  func getTransaction(txHash: String) -> Transaction? {
    return findOne("txHash = '\(txHash)'")
  }
  
  func markAndSaveTransactions(_ transactions: inout [Transaction], address: String) {
    for (i, transaction) in transactions.enumerated() {
      transactions[i].isIncoming = transaction.to == address
    }
    save(transactions)
  }

}
