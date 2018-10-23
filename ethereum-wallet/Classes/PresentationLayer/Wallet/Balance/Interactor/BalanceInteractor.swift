// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


class BalanceInteractor {
  
  weak var output: BalanceInteractorOutput!
  
  var ratesNetworkService: RatesNetworkServiceProtocol!
  var ratesDataStoreService: RatesDataStoreServiceProtocol!
  var walletRepository: WalletRepository!
  var balanceIndexer: BalanceIndexer!
  var balanceUpdater: BalanceUpdater!
  var tokenIndexer: TokenIndexer!
  
  
  let balanceIndexId = Identifier()
  let tokenIndexId = Identifier()
  let walletId = Identifier()
  
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
    balanceIndexer.removeObserver(id: balanceIndexId)
    tokenIndexer.removeObserver(id: tokenIndexId)
    walletRepository.removeObserver(id: walletId)
    balanceUpdater.stop()
  }
}


// MARK: - BalanceInteractorInput

extension BalanceInteractor: BalanceInteractorInput {
  
  func startUpdater() {
    balanceUpdater.start()
  }
  
  func updateBalance() {
    balanceUpdater.update()
  }
  
  func getWallet() {
    walletRepository.addObserver(id: walletId) { [weak self] wallet in
      DispatchQueue.main.async {
        self?.output.didReceiveWallet(wallet)
      }
    }
  }
  
  func getBalance() {
    balanceIndexer.start(id: balanceIndexId) { viewModel in
      DispatchQueue.main.async {
        self.output.didReceiveBalance(viewModel)
      }
    }
  }
  
  func getTokens() {
    tokenIndexer.start(id: tokenIndexId) { viewModels in
      DispatchQueue.main.async {
        self.output.didReceiveTokens(viewModels)
      }
    }
  }
  
}
