// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


class BalanceInteractor {
  enum Signal {
    case coin
  }
  
  weak var output: BalanceInteractorOutput!
  
  var walletNetworkService: WalletNetworkServiceProtocol!
  var walletDataStoreService: WalletDataStoreServiceProtocol!
  var coinDataStoreService: CoinDataStoreServiceProtocol!
  var ratesNetworkService: RatesNetworkServiceProtocol!
  var ratesDataStoreService: RatesDataStoreServiceProtocol!
  var tokensNetworkService: TokensNetworkServiceProtocol!
  var tokensDataStoreService: TokenDataStoreServiceProtocol!
  var etherBalancer: EtherBalancer!
  var coinRepository: CoinRepositiry!
  
  let balanceId = Identifier()
  let coinId = Identifier()
  
  let group = DispatchGroup()
  
  private func updateTokensBalance(_ tokens: [Token], address: String) {
    var updatedTokens = tokens
    for (i, token) in tokens.enumerated() {
      group.enter()
      
      tokensNetworkService.getBalanceForToken(contractAddress: token.address,
                                              address: address,
                                              queue: .global()) { [weak self] result in
                                                switch result {
                                                case .success(let balanceObj):
                                                  updatedTokens[i].balance.raw = balanceObj.balance
                                                case .failure(let error):
                                                  print(error.localizedDescription)
                                                }
                                                self?.group.leave()
      }
    }
    
    group.notify(queue: .global()) { [weak self] in
      self?.tokensDataStoreService.save(updatedTokens)
    }
  }
  
  deinit {
    etherBalancer.removeObserver(id: balanceId)
    coinRepository.removeObserver(id: coinId)
  }
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
  
  func getBalance() {
    etherBalancer.start(id: balanceId) { [weak self] balance in
      self?.output.didReceiveBalance(balance)
    }
  }
  
  func getCoin() {
    coinRepository.addObserver(id: coinId) { [weak self] coin in
      self?.output.didReceiveCoin(coin)
    }
  }
  
  func getTokensFromDataBase() {
    tokensDataStoreService.observe { [weak self] tokens in
      let notEmpty = tokens.filter { $0.balance.raw != 0 }
      self?.output.didReceiveTokens(notEmpty)
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
        self?.updateTokensBalance(tokens, address: address)
      case .failure(let error):
        DispatchQueue.main.async {
          self?.output.didFailedTokensReceiving(with: error)
        }
      }
    }
    
  }
  
}
