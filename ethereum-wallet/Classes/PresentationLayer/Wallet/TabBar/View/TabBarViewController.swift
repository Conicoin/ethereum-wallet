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
    let titles = [Localized.tabBalance(), Localized.tabTransactions(), Localized.tabSettings()]
    for (i, vc) in viewControllers.enumerated() {
      vc.tabBarItem.title = titles[i]
    }
  }

}
