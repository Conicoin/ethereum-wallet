// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  private let liveServices = LiveServices()
  
  private var configurators: [ConfiguratorProtocol] = {
    return [
      MigrationConfigurator(),
      AppearanceConfigurator(),
      ApplicationConfiguratorFactory().create(),
      ThirdPartiesConfigurator()]
  }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    for configurator in configurators {
      configurator.configure()
    }
    
    liveServices.locker.autolock()
            
    return true
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    liveServices.screenLocker.unlock()
    liveServices.locker.autolock()
    liveServices.backupper.autobackup()
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    liveServices.screenLocker.lock()
  }
    
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    liveServices.pushConfigurator.configureRemoteNotifications(token: deviceToken)
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Error register for remote notification: \(error.localizedDescription)")
  }
  
}

extension AppDelegate {
  
  static var currentDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  static var currentWindow: UIWindow {
    return currentDelegate.window!
  }
  
}

