// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation


class BalanceInteractor {
  
  weak var output: BalanceInteractorOutput!

  var walletRepository: WalletRepository!
  var balanceUpdater: BalanceUpdater!
  var ratesUpdater: RatesUpdater!
  var balanceIndexer: BalanceIndexer!
  var tokenIndexer: TokenIndexer!
  
  
  let balanceIndexId = Identifier()
  let tokenIndexId = Identifier()
  let walletId = Identifier()
  
  deinit {
    balanceIndexer.removeObserver(id: balanceIndexId)
    tokenIndexer.removeObserver(id: tokenIndexId)
    walletRepository.removeObserver(id: walletId)
    balanceUpdater.stop()
    ratesUpdater.stop()
  }
}


// MARK: - BalanceInteractorInput

extension BalanceInteractor: BalanceInteractorInput {
  
  func startBalanceUpdater() {
    balanceUpdater.start()
  }
  
  func startRatesUpdater() {
    ratesUpdater.start()
  }
  
  func updateBalance() {
    balanceUpdater.update()
  }
  
  func getWallet() {
    walletRepository.addObserver(id: walletId) { [weak self] wallet in
      self?.output.didReceiveWallet(wallet)
    }
  }
  
  func getBalance() {
    balanceIndexer.start(id: balanceIndexId) { [weak self] viewModel in
      self?.output.didReceiveBalance(viewModel)
    }
  }
  
  func getTokens() {
    tokenIndexer.start(id: tokenIndexId) { [weak self] viewModels in
      self?.output.didReceiveTokens(viewModels)
    }
  }
  
}
