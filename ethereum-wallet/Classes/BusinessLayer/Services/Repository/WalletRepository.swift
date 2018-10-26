//
//  WalletRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol WalletRepository {
  var wallet: Wallet { get }
  func addObserver(id: Identifier, callback: @escaping (Wallet) -> Void)
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
  
  func addObserver(id: Identifier, callback: @escaping (Wallet) -> Void) {
    callback(wallet)
    let observer = Observer<Wallet>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  func removeObserver(id: Identifier) {
    channel.removeObserver(withId: id)
  }
  
}
