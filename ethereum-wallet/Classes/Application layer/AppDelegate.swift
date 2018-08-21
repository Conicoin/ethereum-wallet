// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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

