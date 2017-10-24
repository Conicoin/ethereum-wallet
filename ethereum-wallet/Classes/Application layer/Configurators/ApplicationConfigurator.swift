//
//  ApplicationConfigurator.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 18/06/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import Foundation

class ApplicationConfigurator: ConfiguratorProtocol {
  
  func configure() {
    if Defaults.isAuthorized {
      AppDelegate.currentWindow.rootViewController = TabBarModule.create().viewController
    } else {
      AppDelegate.currentWindow.rootViewController = WelcomeModule.create().viewController
    }
  }
  
}
