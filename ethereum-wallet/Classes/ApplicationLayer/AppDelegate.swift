// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  private let app = Application()
  
  private lazy var configurators: [ConfiguratorProtocol] = {
    return [
      MigrationConfigurator(),
      AppearanceConfigurator(),
      ApplicationConfiguratorFactory(app: self.app).create(),
      ThirdPartiesConfigurator()]
  }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    for configurator in configurators {
      configurator.configure()
    }
    
    app.locker.autolock()
            
    return true
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    app.screenLocker.unlock()
    app.locker.autolock()
    app.backupper.autobackup()
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    app.screenLocker.lock()
  }
    
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    app.pushConfigurator.configureRemoteNotifications(token: deviceToken)
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

