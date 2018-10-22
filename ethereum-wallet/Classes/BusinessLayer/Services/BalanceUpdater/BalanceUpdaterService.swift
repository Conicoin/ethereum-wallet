//
//  BalanceUpdater.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 22/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol BalanceUpdater {
  func start()
  func stop()
  func update()
}

class BalanceUpdaterService: BalanceUpdater {
  
  var queue = DispatchQueue(label: "BalanceUpdaterQueue")
  var interval = 10
  var timer: DispatchSourceTimer?
  
  let walletRepository: WalletRepository
  let transactionDataStoreService: TransactionsDataStoreServiceProtocol
  let transactionNetworkService: TransactionsNetworkServiceProtocol
  init(walletRepository: WalletRepository,
       transactionDataStoreService: TransactionsDataStoreServiceProtocol,
       transactionNetworkService: TransactionsNetworkServiceProtocol) {
    self.walletRepository = walletRepository
    self.transactionDataStoreService = transactionDataStoreService
    self.transactionNetworkService = transactionNetworkService
  }
  
  func start() {
    timer = Timer.createDispatchTimer(interval: .seconds(interval),
                                      leeway: .seconds(0),
                                      queue: queue) { [unowned self] in
                                        self.updateTick()
    }
  }
  
  func stop() {
    timer?.cancel()
    timer = nil
  }
  
  func update() {
    updateTick()
  }
  
  // MARK: Privates
  
  private func updateTick() {
    let address = self.walletRepository.wallet.address!
    getTransactions(address: address)
    getTokenTransactions(address: address)
  }
  
  private func getTransactions(address: String) {
    transactionNetworkService.getTransactions(address: address, queue: queue)  { result in
      switch result {
      case .success(let transactions):
        let txs = transactions.filter { !$0.input.starts(with: "0xa9059cbb") }
        self.transactionDataStoreService.markAndSaveTransactions(txs, address: address)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func getTokenTransactions(address: String) {
    transactionNetworkService.getTokenTransactions(address: address, queue: queue) { [unowned self] result in
      switch result {
      case .success(let transactions):
        self.transactionDataStoreService.markAndSaveTransactions(transactions, address: address)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
}
