// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import UIKit
import UserNotifications

class PushService: PushServiceProtocol {
    
  func registerForRemoteNotifications(_ completion: @escaping (Result<Bool>) -> Void) {
   
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
      
      guard granted else {
        completion(.failure(error ?? PushError.disabled))
        return
      }
      
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        guard settings.authorizationStatus == .authorized else {
          completion(.failure(error ?? PushError.disabled))
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
