// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


class BalanceInteractor {
  
  weak var output: BalanceInteractorOutput!
  
  var walletNetworkService: WalletNetworkServiceProtocol!
  var coinDataStoreService: CoinDataStoreServiceProtocol!
  var ratesNetworkService: RatesNetworkServiceProtocol!
  var ratesDataStoreService: RatesDataStoreServiceProtocol!
  var tokensNetworkService: TokensNetworkServiceProtocol!
  var tokensDataStoreService: TokenDataStoreServiceProtocol!
  var walletRepository: WalletRepository!
  var coinIndexer: CoinIndexer!
  var tokenIndexer: TokenIndexer!
  
  
  let coinIndexId = Identifier()
  let tokenIndexId = Identifier()
  let walletId = Identifier()
  
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
  
  private func updateRates(currencies: [String]) {
    guard currencies.count > 0 else {
      return
    }
    
    ratesNetworkService.getRate(currencies: currencies, queue: .global()) { [weak self] result in
      switch result {
      case .success(let rates):
        self?.ratesDataStoreService.save(rates)
      case .failure(let error):
        DispatchQueue.main.async {
          self?.output.didFailedWalletReceiving(with: error)
        }
      }
    }
  }
  
  deinit {
    coinIndexer.removeObserver(id: coinIndexId)
    tokenIndexer.removeObserver(id: tokenIndexId)
    walletRepository.removeObserver(id: walletId)
  }
}


// MARK: - BalanceInteractorInput

extension BalanceInteractor: BalanceInteractorInput {
  
  func getWallet() {
    walletRepository.addObserver(id: walletId) { [weak self] wallet in
      self?.output.didReceiveWallet(wallet)
    }
  }
  
  func getCoin() {
    coinIndexer.start(id: coinIndexId) { coin in
      self.output.didReceiveCoin(coin)
    }
  }
  
  func getTokens() {
    tokenIndexer.start(id: tokenIndexId) { index in
      self.output.didReceiveTokens(index)
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
        self?.updateRates(currencies: [coin.balance.iso])
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
        self?.updateRates(currencies: tokens.map({$0.balance.iso}))
      case .failure(let error):
        DispatchQueue.main.async {
          self?.output.didFailedTokensReceiving(with: error)
        }
      }
    }
  }
  
}
