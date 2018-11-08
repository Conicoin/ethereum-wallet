// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol WalletRepository {
  var wallet: Wallet { get }
  func addObserver(id: Identifier, fire: Bool, callback: @escaping (Wallet) -> Void)
  func removeObserver(id: Identifier)
}

class WalletRepositoryService: WalletRepository {
  
  var wallet: Wallet
  
  let channel: Channel<Wallet>
  let walletDataStoreService: WalletDataStoreServiceProtocol
  init(channel: Channel<Wallet>, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.channel = channel
    
    // To not release notification block
    self.walletDataStoreService = walletDataStoreService
    
    self.wallet = walletDataStoreService.getWallet()
    walletDataStoreService.observe { wallet in
      self.wallet = wallet
      channel.send(wallet)
    }
  }
  
  func addObserver(id: Identifier, fire: Bool, callback: @escaping (Wallet) -> Void) {
    if fire {
      callback(wallet)
    }
    let observer = Observer<Wallet>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  func removeObserver(id: Identifier) {
    channel.removeObserver(withId: id)
  }
  
}
