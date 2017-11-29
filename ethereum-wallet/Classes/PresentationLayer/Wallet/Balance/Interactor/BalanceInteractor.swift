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


class BalanceInteractor {
  weak var output: BalanceInteractorOutput!
  
  var walletNetworkService: WalletNetworkServiceProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var coinDataStoreService: CoinDataStoreServiceProtocol!
  var ratesNetworkService: RatesNetworkServiceProtocol!
  var ratesDataStoreService: RatesDataStoreServiceProtocol!
  
}


// MARK: - BalanceInteractorInput

extension BalanceInteractor: BalanceInteractorInput {
  
  func updateRates() {
    var coins = coinDataStoreService.find()
    
    guard coins.count > 0 else {
      return
    }
    
    let currencies = coins.map { $0.balance.iso }
    ratesNetworkService.getRate(currencies: currencies) { [unowned self] result in
      switch result {
      case .success(let rates):
        
        for (i, coin) in coins.enumerated() {
          let rates = rates.filter { $0.from == coin.balance.iso }
          coins[i].rates = rates
        }
        self.coinDataStoreService.save(coins)
        
      case .failure(let error):
        self.output.didFailedWalletReceiving(with: error)
      }
    }
  }
  
  func getWalletFromDataBase() {
    walletDataStoreService.observe { [unowned self] wallet in
      self.output.didReceiveWallet(wallet)
    }
  }
  
  func getCoinsFromDataBase() {
    coinDataStoreService.observe { [unowned self] coins in
      self.output.didReceiveCoins(coins)
    }
  }
  
  func getEthereumFromNetwork() {
    let wallet = walletDataStoreService.getWallet()
    walletNetworkService.getBalance(address: wallet.address) { [unowned self] result in
      switch result {
      case .success(let balance):
        let ether = Ether(balance)
        var coin = Coin()
        coin.balance = ether
        coin.lastUpdateTime = Date()
        coin.rates = [Rate]() // TODO: avoid rewriting
        self.coinDataStoreService.save(coin)
        self.updateRates()
      case .failure(let error):
        self.output.didFailedWalletReceiving(with: error)
      }
    }
  }
  
}
