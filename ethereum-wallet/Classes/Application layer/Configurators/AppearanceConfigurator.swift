// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit

class AppearanceConfigurator: ConfiguratorProtocol {
  
  func configure() {
    /* Uncomment to use custom icon
    let back = UIImage(named: "BackIcon")
    UIBarButtonItem.appearance().setBackButtonBackgroundImage(back, for: .normal, barMetrics: .defaultPrompt)
    */
    UINavigationBar.appearance().isTranslucent = true
    UINavigationBar.appearance().barTintColor = .clear
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.Color.black]
    UINavigationBar.appearance().shadowImage = UIImage()
    UIBarButtonItem.appearance().tintColor = Theme.Color.black
  }
  
}
