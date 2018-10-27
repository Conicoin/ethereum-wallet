// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class PushConfigurator: PushConfiguratorProtocol {
  
  let pushNetworkService: PushNetworkServiceProtocol
  let walletRepository: WalletRepository
  
  let maxAttemptsCount = 3
  var attemptsCount = 0
  
  init(pushNetworkService: PushNetworkServiceProtocol, walletRepository: WalletRepository) {
    self.pushNetworkService = pushNetworkService
    self.walletRepository = walletRepository
  }
  
  func configureRemoteNotifications(token: Data) {
    let wallet = walletRepository.wallet
    let tokenString = token.hex()
    registerDeviceToken(address: wallet.address, token: tokenString)
  }
  
  func unregister() {
    let wallet = walletRepository.wallet
    
    pushNetworkService.unregister(queue: .main) { result in
      switch result {
      case .success:
        print("Push notification configuration unregistered")
      case .failure(let error):
        print("Push notification configuration unregister error: \(error.localizedDescription)")
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
