// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class TabBarViewController: UITabBarController {

  var output: TabBarViewOutput!

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
    tabBar.isTranslucent = false
    tabBar.barTintColor = .white
    tabBar.tintColor = Theme.Color.blue
    tabBar.shadowImage = UIImage()
    tabBar.backgroundImage = UIImage()
    tabBar.layer.shadowColor = UIColor.blue.cgColor
    tabBar.layer.shadowOffset = CGSize(width: 0, height: -6)
    tabBar.layer.shadowRadius = 6
    tabBar.layer.shadowOpacity = 0.04
  }
    
}


// MARK: - TabBarViewInput

extension TabBarViewController: TabBarViewInput {

  func setupInitialState() {

  }
  
  func setTitles() {
    guard let viewControllers = viewControllers else { return }
    let titles = [
      Localized.tabBalance(),
      Localized.tabPartners(),
      Localized.tabTransactions(),
      Localized.tabSettings()
    ]
    for (i, vc) in viewControllers.enumerated() {
      vc.tabBarItem.title = titles[i]
    }
  }

}
