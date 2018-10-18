// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class TabBarPresenter {
  
  weak var view: TabBarViewInput!
  weak var output: TabBarModuleOutput?
  var interactor: TabBarInteractorInput!
  var router: TabBarRouterInput!
  
  private func insertViewControllers() {
    let viewControllers = router.getTabViewControllers()
    view.viewControllers = viewControllers
  }
  
}


// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {
  
  func viewIsReady() {
    view.setupInitialState()
    insertViewControllers()
    view.setTitles()
    interactor.startSynchronization()
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

  }
  
  func syncDidFinished() {

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

}
