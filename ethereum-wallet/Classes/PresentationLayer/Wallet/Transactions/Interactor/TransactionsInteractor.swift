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


class TransactionsInteractor {
  weak var output: TransactionsInteractorOutput!
  
  var transactionsNetworkService: TransactionsNetworkServiceProtocol!
  var transactionsDataStoreService: TransactionsDataStoreServiceProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
}


// MARK: - TransactionsInteractorInput

extension TransactionsInteractor: TransactionsInteractorInput {
  
  func getTransactions() {
    transactionsDataStoreService.observe { [unowned self] transactions in
      self.output.didReceiveTransactions(transactions.map { TransactionDisplayer(tx: $0) })
    }
  }
  
  func getWallet() {
    walletDataStoreService.getWallet(queue: .main) { wallet in
      self.output.didReceiveWallet(wallet)
    }
  }
  
  func loadTransactions(address: String, page: Int, limit: Int) {
    transactionsNetworkService.getTransactions(address: address, page: page, limit: limit, queue: .global()) { [unowned self] result in
      switch result {
      case .success(let transactions):
        self.transactionsDataStoreService.markAndSaveTransactions(transactions, address: address)
        DispatchQueue.main.async {
          self.output.didReceiveTransactions()
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self.output.didFailedTransactionsReceiving(with: error)
        }
      }
    }
  }
  
}

