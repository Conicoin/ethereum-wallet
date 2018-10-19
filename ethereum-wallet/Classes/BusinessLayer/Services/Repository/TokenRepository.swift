//
//  TokenRepository.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/10/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation


protocol TokenRepository {
  var tokens: [Token] { get }
  func addObserver(id: Identifier, callback: @escaping ([Token]) -> Void)
  func removeObserver(id: Identifier)
}

class TokenRepositoryService: TokenRepository {
  
  var tokens: [Token] = []
  
  let channel: Channel<[Token]>
  let tokenDataStoreService: TokenDataStoreServiceProtocol
  init(channel: Channel<[Token]>, tokenDataStoreService: TokenDataStoreServiceProtocol) {
    self.channel = channel
    
    // To not release notification block
    self.tokenDataStoreService = tokenDataStoreService
    
    tokenDataStoreService.observe { tokens in
      self.tokens = tokens
      channel.send(tokens)
    }
  }
  
  func addObserver(id: Identifier, callback: @escaping ([Token]) -> Void) {
    callback(tokens)
    let observer = Observer<[Token]>(id: id, callback: callback)
    channel.addObserver(observer)
  }
  
  func removeObserver(id: Identifier) {
    channel.removeObserver(withId: id)
  }
  
}
