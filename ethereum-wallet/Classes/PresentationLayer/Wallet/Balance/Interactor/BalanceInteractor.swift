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


class BalanceInteractor {
  weak var output: BalanceInteractorOutput!
  
  var walletNetworkService: WalletNetworkServiceProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var coinDataStoreService: CoinDataStoreServiceProtocol!
  var ratesNetworkService: RatesNetworkServiceProtocol!
  var ratesDataStoreService: RatesDataStoreServiceProtocol!
  var tokensNetworkService: TokensNetworkServiceProtocol!
  var tokensDataStoreService: TokenDataStoreServiceProtocol!
}


// MARK: - BalanceInteractorInput

extension BalanceInteractor: BalanceInteractorInput {
  
  func updateRates() {
    // To background thread
    var coins = coinDataStoreService.find()
    var tokens = tokensDataStoreService.find()
    let coinsCurrenies = coins.map { $0.balance.iso }
    let tokensCurrencies = tokens.map { $0.balance.iso }
    let currencies = coinsCurrenies + tokensCurrencies
    
    guard currencies.count > 0 else {
      return
    }
    
    ratesNetworkService.getRate(currencies: currencies, queue: .global()) { [weak self] result in
      switch result {
      case .success(let rates):
        // TODO: Refactor - move to rate service
        for (i, coin) in coins.enumerated() {
          let rates = rates.filter { $0.from == coin.balance.iso }
          coins[i].rates = rates
        }
        self?.coinDataStoreService.save(coins)
        
        for (i, token) in tokens.enumerated() {
          let rates = rates.filter { $0.from == token.balance.iso }
          tokens[i].rates = rates
        }
        self?.tokensDataStoreService.save(tokens)
        
      case .failure(let error):
        DispatchQueue.main.async {
          self?.output.didFailedWalletReceiving(with: error)
        }
      }
    }
  }
  
  func getWalletFromDataBase() {
    walletDataStoreService.observe { [weak self] wallet in
      self?.output.didReceiveWallet(wallet)
    }
  }
  
  func getCoinsFromDataBase() {
    coinDataStoreService.observe { [weak self] coins in
      self?.output.didReceiveCoins(coins)
    }
  }
    
  func getTokensFromDataBase() {
    tokensDataStoreService.observe { [weak self] tokens in
        self?.output.didReceiveTokens(tokens)
    }
  }
  
  func getEthereumFromNetwork(address: String) {
    walletNetworkService.getBalance(address: address, queue: .global()) { [weak self] result in
      switch result {
      case .success(let balance):
        let ether = Ether(weiString: balance)
        var coin = Coin()
        coin.balance = ether
        self?.coinDataStoreService.save(coin)
        self?.updateRates()
      case .failure(let error):
        DispatchQueue.main.async {
          self?.output.didFailedWalletReceiving(with: error)
        }
      }
    }
  }
  
  func getTokensFromNetwork(address: String) {
    tokensNetworkService.getTokens(address: address, queue: .global()) { [weak self] result in
      switch result {
      case .success(let tokens):
        self?.tokensDataStoreService.save(tokens)
      case .failure(let error):
        DispatchQueue.main.async {
          self?.output.didFailedTokensReceiving(with: error)
        }
      }
    }
    
  }
  
}
