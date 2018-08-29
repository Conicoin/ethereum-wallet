// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class TabBarPresenter {
  
  weak var view: TabBarViewInput!
  weak var output: TabBarModuleOutput?
  var interactor: TabBarInteractorInput!
  var router: TabBarRouterInput!
  
  private lazy var balanceModule: BalanceModuleInput = {
    let module = BalanceModule.create()
    module.output = self
    return module
  }()
  private lazy var transactionsModule: TransactionsModuleInput = TransactionsModule.create()
  private lazy var settingsModule: SettingsModuleInput = SettingsModule.create()
  
  private func insertViewControllers() {
    
    view.viewControllers = [
      balanceModule.viewController.wrapToNavigationController(),
      transactionsModule.viewController.wrapToNavigationController(),
      settingsModule.viewController.wrapToNavigationController()
    ]
    view.setTitles()
  }
  
}


// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    insertViewControllers()
  }
}


// MARK: - TabBarInteractorOutput

extension TabBarPresenter: TabBarInteractorOutput {
  
  func syncDidUpdateBalance(_ balance: Decimal) {
    
  }
  
  func syncDidFailedWithError(_ error: Error) {
    DispatchQueue.main.async {
      error.showAllertIfNeeded(from: self.view.viewController)
    }
  }
  
  func syncDidChangeProgress(current: Int64, total: Int64) {
    balanceModule.syncDidChangeProgress(current: current, total: total)
  }
  
  func syncDidFinished() {
    balanceModule.syncDidFinished()
  }
  
}


// MARK: - TabBarModuleInput

extension TabBarPresenter: TabBarModuleInput {
  
  func present() {
    view.present()
  }
  
}


// MARK: - BalanceModuleOutput

extension TabBarPresenter: BalanceModuleOutput {
  
  func balanceViewIsReady() {
    interactor.startSynchronization()
  }
  
}
