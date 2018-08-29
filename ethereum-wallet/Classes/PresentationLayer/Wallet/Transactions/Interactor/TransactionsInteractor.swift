// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


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

