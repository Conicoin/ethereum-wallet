//
//  TabBarTabBarViewController.swift
//  ethereum-wallet
//
//  Created by Artur Guseynov on 21/10/2017.
//  Copyright © 2017 Artur Guseinov. All rights reserved.
//

import UIKit


class TabBarViewController: UITabBarController {

  var output: TabBarViewOutput!

  // MARK: Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    output.viewIsReady()
  }
    
}


// MARK: - TabBarViewInput

extension TabBarViewController: TabBarViewInput {

  func setupInitialState() {

  }

}
