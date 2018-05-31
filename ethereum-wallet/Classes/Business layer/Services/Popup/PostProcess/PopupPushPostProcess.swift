//
//  PopupPushPostProcess.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 31/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Alamofire
import UserNotifications

class PopupPushPostProcess: PopupPostProcessProtocol {
  
  static let shared = PopupPushPostProcess()
  
  var completion: PopupPostProcessCallback?
  
  var pushService: PushNetworkServiceProtocol?
  var walletDataStoreService: WalletDataStoreServiceProtocol?
  
  func onConfirm(_ completion: @escaping (Result<Bool>) -> Void) {
    self.completion = nil
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
      guard granted else {
        completion(.failure(error!))
        return
      }
      
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        guard settings.authorizationStatus == .authorized else {
          completion(.failure(error!))
          return
        }
        
        self.completion = completion
        
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
  }
  
  func didRegister(token: String) {
    walletDataStoreService?.getWallet(queue: .global()) { wallet in
      self.pushService!.register(token: token, address: wallet.address, queue: .global()) { result in
        self.completion?(.success(true))
      }
    }
  }
  
  func didFailToRegister(with error: Error) {
    completion?(.failure(error))
  }
  
}

