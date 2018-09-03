// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class PushConfigurator: PushConfiguratorProtocol {
  
  let pushNetworkService: PushNetworkServiceProtocol
  let walletDataStoreService: WalletDataStoreServiceProtocol
  
  let maxAttemptsCount = 3
  var attemptsCount = 0
  
  init(pushNetworkService: PushNetworkServiceProtocol, walletDataStoreService: WalletDataStoreServiceProtocol) {
    self.pushNetworkService = pushNetworkService
    self.walletDataStoreService = walletDataStoreService
  }
  
  func configureRemoteNotifications(token: Data) {
    walletDataStoreService.getWallet(queue: .global()) { [unowned self] wallet in
      let tokenString = token.hex()
      self.registerDeviceToken(address: wallet.address, token: tokenString)
    }
  }
  
  func unregister() {
    walletDataStoreService.getWallet(queue: .global()) { [unowned self ]wallet in
      self.pushNetworkService.unregister(queue: .main) { result in
        switch result {
        case .success:
          print("Push notification configuration unregistered")
        case .failure(let error):
          print("Push notification configuration unregister error: \(error.localizedDescription)")
        }
      }
    }
  }
  
  private func registerDeviceToken(address: String, token: String) {
    pushNetworkService.register(token: token, address: address, queue: .global())  { result in
      switch result {
      case .success:
        print("Push notifications sucessfuly configurated")
      case .failure(let error):
        print("Couldn't configure push notifications, retrying... : \(error.localizedDescription)")
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
          guard self.attemptsCount < self.maxAttemptsCount else {
            return
          }
          
          self.attemptsCount += 1
          
          self.registerDeviceToken(address: address, token: token)
        }
      }
    }
  }
  
}
