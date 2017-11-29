// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2017 Artur Guseinov
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


class TabBarInteractor {
  weak var output: TabBarInteractorOutput!
  var ethereumService: EthereumCoreProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var transactionsDataStoreServise: TransactionsDataStoreServiceProtocol!
  var coinsDataStoreService: CoinDataStoreServiceProtocol!
}


// MARK: - TabBarInteractorInput

extension TabBarInteractor: TabBarInteractorInput {
  
  func startSynchronization() {
    let balanceHandler = BalanceHandler(didUpdateBalance: { [unowned self] newBalanceHex, time in
      
      guard var coin = self.coinsDataStoreService.find(withIso: "ETH") else {
        return
      }
      
      let interval = TimeInterval(time)
      let date = Date(timeIntervalSince1970: interval)
      
      guard coin.lastUpdateTime < date else {
        return
      }
      
      let newBalance = Decimal(hexString: newBalanceHex)
      coin.balance = Ether(newBalance as NSDecimalNumber) // TODO: Remove  ALL NSDecimalNumbers
      coin.lastUpdateTime = date
      self.coinsDataStoreService.save(coin)
      
      self.output.syncDidUpdateBalance(Decimal(hexString: newBalanceHex))
    }, didReceiveTransactions: { [unowned self] gethTransactions, time in
      
      var transactions = gethTransactions.map { Transaction.mapFromGethTransaction($0, time: TimeInterval(time)) }
      let wallet = self.walletDataStoreService.getWallet()
      self.transactionsDataStoreServise.markAndSaveTransactions(&transactions, address: wallet.address)
      
    }, didUpdateGasLimit: { [unowned self] gasLimit in
      var wallet = self.walletDataStoreService.getWallet()
      wallet.gasLimit = Decimal(gasLimit)
      self.walletDataStoreService.save(wallet)
    })
    
    let syncHandler = SyncHandler(didChangeProgress: { [unowned self] current, total in
      DispatchQueue.main.async {
        self.output.syncDidChangeProgress(current: current, total: total)
      }
    }, didFinished: { [unowned self] in
      DispatchQueue.main.async {
        self.output.syncDidFinished()
      }
    })
    
    ethereumService.syncQueue.async {
      do  {
        try Ethereum.core.startSync(chain: Defaults.chain, balanceHandler: balanceHandler, syncHandler: syncHandler)
        
      } catch {
        DispatchQueue.main.async {
          self.output.syncDidFailedWithError(error)
        }
      }
    }
    
  }

}
