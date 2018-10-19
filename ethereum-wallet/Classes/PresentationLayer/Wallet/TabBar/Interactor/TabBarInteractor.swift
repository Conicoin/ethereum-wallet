// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import Geth

class TabBarInteractor {
  weak var output: TabBarInteractorOutput!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var coinsDataStoreService: CoinDataStoreServiceProtocol!
  var ethereumService: EthereumCoreProtocol!
  var transactionsDataStoreServise: TransactionsDataStoreServiceProtocol!
}


// MARK: - TabBarInteractorInput

extension TabBarInteractor: TabBarInteractorInput {
  
  func startSynchronization() {
    Ethereum.syncQueue.async { [unowned self] in
      do  {
        try self.ethereumService.start(chain: Defaults.chain, delegate: self)
        
      } catch {
        DispatchQueue.main.async { [unowned self] in
          self.output.syncDidFailedWithError(error)
        }
      }
    }
    
  }

}


// MARK: - SyncCoordinatorDelegate

extension TabBarInteractor: SyncCoordinatorDelegate {
  
  func syncDidChangeProgress(current: Int64, max: Int64) {
    DispatchQueue.main.async {
      self.output.syncDidChangeProgress(current: current, total: max)
    }
  }
  
  func syncDidFinished() {
    DispatchQueue.main.async {
      self.output.syncDidFinished()
    }
  }
  
  func syncDidUpdateBalance(_ balanceHex: String, timestamp: Int64) {
    var coin = coinsDataStoreService.find(withIso: "ETH")
    
    let interval = TimeInterval(timestamp)
    let date = Date(timeIntervalSince1970: interval)
    
    guard coin.lastUpdateTime < date else {
      return
    }
    
    let newBalance = Decimal(hexString: balanceHex)
    coin.balance = Ether(newBalance)
    coin.lastUpdateTime = date
    coinsDataStoreService.save(coin)
    
    output.syncDidUpdateBalance(newBalance)
  }
  
  func syncDidUpdateGasLimit(_ gasLimit: Int64) {
    walletDataStoreService.getWallet(queue: .global()) { wallet in
      var updated = wallet
      updated.gasLimit = Decimal(gasLimit)
      self.walletDataStoreService.save(updated)
    }
  }
  
  func syncDidReceiveTransactions(_ gethTransactions: [GethTransaction], timestamp: Int64) {
    // TODO: Storing transaction for LES Sync
  }
  
}
