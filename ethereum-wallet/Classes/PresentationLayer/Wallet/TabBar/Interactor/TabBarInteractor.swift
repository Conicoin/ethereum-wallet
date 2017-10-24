//
//  TabBarTabBarInteractor.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation


class TabBarInteractor {
  weak var output: TabBarInteractorOutput!
  var ethereumService: EthereumCoreProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var transactionsDataStoreServise: TransactionsDataStoreServiceProtocol!
}


// MARK: - TabBarInteractorInput

extension TabBarInteractor: TabBarInteractorInput {
  
  func startSynchronization() {
    let balanceHandler = BalanceHandler(didUpdateBalance: { newBalance in
      self.output.syncDidUpdateBalance(newBalance)
    }, didReceiveTransactions: { gethTransactions in
      let transactions = gethTransactions.map { Transaction.mapFromGethTransaction($0) }
      self.transactionsDataStoreServise.saveTransactions(transactions)
    })
    
    let syncHandler = SyncHandler(didChangeProgress: { current, total in
      DispatchQueue.main.async {
        self.output.syncDidChangeProgress(current: current, total: total)
      }
    }, didFinished: {
      DispatchQueue.main.async {
        self.output.syncDidFinished()
      }
    })
    
    ethereumService.syncQueue.async {
      do  {
        try Ethereum.core.startSync(balanceHandler: balanceHandler, syncHandler: syncHandler)
        
      } catch {
        DispatchQueue.main.async {
          self.output.syncDidFailedWithError(error)
        }
      }
    }
    
  }
  
  func getTransactions(from block: Int, to: Int) {
    let wallet = walletDataStoreService.getWallet()
    Logger.debug("Start searching transactions")
    let gethTransactions = ethereumService.getTransactions(address: wallet.address, startBlockNumber: Int64(block), endBlockNumber: Int64(to))
    Logger.debug("End searching transactions")
    let transactions = gethTransactions.map { Transaction.mapFromGethTransaction($0) }
    transactionsDataStoreServise.saveTransactions(transactions)
    let keychain = Keychain()
    keychain.firstEnterBlock = to
  }

}
