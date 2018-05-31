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
  
  private var locker: LockerProtocol = LockerFactory().create()
  private var screenLocker: ScreenLockerProtocol = ScreenLocker()
  private var configurators: [ConfiguratorProtocol] = {
    return [
      AppearanceConfigurator(),
      ApplicationConfigurator(),
      ThirdPartiesConfigurator(),
      MigrationConfigurator()]
  }()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    for configurator in configurators {
      configurator.configure()
    }
            
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    locker.autolock()
    screenLocker.unlock()
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    screenLocker.lock()
  }
    
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data -> String in
      return String(format: "%02.2hhx", data)
    }
    
    let token = tokenParts.joined()
    PopupPushPostProcess.shared.didRegister(token: token)
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    PopupPushPostProcess.shared.didFailToRegister(with: error)
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

