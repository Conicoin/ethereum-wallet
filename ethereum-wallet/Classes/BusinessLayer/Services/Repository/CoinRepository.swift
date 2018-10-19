//
//  CoinRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

protocol CoinRepositiry {
  var coin: Coin { get }
  func addObserver(id: Identifier, callback: @escaping (Coin) -> Void)
  func removeObserver(id: Identifier)
}

class CoinRepositiryService: CoinRepositiry {
  
  var coin: Coin
  
  let channel: Channel<Coin>
  let coinDataStoreService: CoinDataStoreServiceProtocol
  init(channel: Channel<Coin>, coinDataStoreService: CoinDataStoreServiceProtocol) {
    self.channel = channel
    
    // To not release notification block
    self.coinDataStoreService = coinDataStoreService
    
    self.coin = coinDataStoreService.find(withIso: "ETH")
    coinDataStoreService.observe { coins in
      if let coin = coins.first {
        self.coin = coin
        self.channel.send(coin)
      }
    }
  }
  
  func addObserver(id: Identifier, callback: @escaping (Coin) -> Void) {
    callback(coin)
    let observer = Observer<Coin>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  func removeObserver(id: Identifier) {
    channel.removeObserver(withId: id)
  }
  
}
