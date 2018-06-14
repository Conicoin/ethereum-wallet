//
//  PushService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 01/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation
import Alamofire
import UserNotifications

class PushService: PushServiceProtocol {
    
  func registerForRemoteNotifications(_ completion: @escaping (Result<Bool>) -> Void) {
   
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
        
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
          completion(.success(true))
        }
      }
    }
  }
  
  func unregister() {
    UIApplication.shared.unregisterForRemoteNotifications()
  }
    
}
