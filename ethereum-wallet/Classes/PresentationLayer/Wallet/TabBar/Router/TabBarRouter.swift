// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation
import UIKit


class TabBarRouter {
  var app: Application!
  
  lazy var balanceModule: BalanceModuleInput = BalanceModule.create(app: app)
  lazy var transactionsModule: TransactionsModuleInput = TransactionsModule.create(app: app)
  lazy var settingsModule: SettingsModuleInput = SettingsModule.create(app: app)
}


// MARK: - TabBarRouterInput

extension TabBarRouter: TabBarRouterInput {
  
  func getTabViewControllers() -> [UIViewController] {
    return [
      balanceModule.viewController.wrapToNavigationController(),
      transactionsModule.viewController.wrapToNavigationController(),
      settingsModule.viewController.wrapToNavigationController()
    ]
  }
}
